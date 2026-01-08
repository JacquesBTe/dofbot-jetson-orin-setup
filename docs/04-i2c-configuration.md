# I2C Configuration - THE CRITICAL FIX

## The Problem

The DOFBOT servo controller communicates via I2C. However:

- **Jetson Nano (Tegra210)**: Servo controller on I2C bus 1
- **Jetson Orin Nano (Tegra234)**: Servo controller on I2C bus 7

Yahboom's software is hardcoded for bus 1, causing "I2C error" messages.

## Detection

Inside the Docker container:
```bash
# Install I2C tools
apt-get update && apt-get install -y i2c-tools

# Scan all I2C buses
i2cdetect -y -r 1  # Empty on Orin Nano
i2cdetect -y -r 7  # Should show device at 0x15
```

Expected output for bus 7:
```
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
10: -- -- -- -- -- 15 -- -- -- -- -- -- -- -- -- --
```

The `15` is your servo controller!

## The Fix

Edit the Arm library:
```bash
# Inside Docker container
cd /root/yahboom_backup/Dofbot/0.py_install/Arm_Lib

# Make the change
sed -i 's/self.bus = smbus.SMBus(1)/self.bus = smbus.SMBus(7)/' Arm_Lib.py

# Verify the change
grep "self.bus = smbus" Arm_Lib.py
# Should output: self.bus = smbus.SMBus(7)
```

**Or manually edit line 11:**
```python
# OLD (line 11):
self.bus = smbus.SMBus(1)

# NEW (line 11):
self.bus = smbus.SMBus(7)
```

## Verification

Test the fix:
```python
#!/usr/bin/env python3
import sys
sys.path.append('/root/yahboom_backup/Dofbot/0.py_install')
from Arm_Lib import Arm_Device
import time

Arm = Arm_Device()
Arm.Arm_serial_set_torque(1)
print("Moving servo 1...")
Arm.Arm_serial_servo_write(1, 120, 500)
time.sleep(1)
Arm.Arm_serial_servo_write(1, 90, 500)
print("Success!")
```

If the arm moves without "I2C error" messages, the fix worked!

## Why This Happens

Different Jetson models route I2C differently:
- Jetson Nano (2019): `/dev/i2c-1` → 40-pin header
- Jetson Orin Nano (2023): `/dev/i2c-7` → 40-pin header

This is a hardware design difference, not a software bug.

Next: [Testing Basic Control](05-testing-basic-control.md)
