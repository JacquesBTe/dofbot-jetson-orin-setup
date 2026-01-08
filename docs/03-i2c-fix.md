# The Critical I2C Fix

## Problem
Yahboom code expects I2C bus 1, but Orin Nano uses bus 7.

## Detection
```bash
i2cdetect -y -r 7
# Should show device at address 0x15
```

## Fix
```bash
sed -i 's/self.bus = smbus.SMBus(1)/self.bus = smbus.SMBus(7)/' \
  /root/yahboom_backup/Dofbot/0.py_install/Arm_Lib/Arm_Lib.py
```

## Verification
```python
from Arm_Lib import Arm_Device
Arm = Arm_Device()  # Should NOT show I2C errors
```

Next: [Examples](04-examples.md)
