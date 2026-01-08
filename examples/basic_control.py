#!/usr/bin/env python3
"""Basic servo control example"""
import sys
import time
sys.path.append('/root/yahboom_backup/Dofbot/0.py_install')
from Arm_Lib import Arm_Device

Arm = Arm_Device()
Arm.Arm_serial_set_torque(1)

# Control individual servos
print("Servo 1 (base): 0-180")
Arm.Arm_serial_servo_write(1, 120, 1000)
time.sleep(1)

# Control all servos at once
print("All servos to 90 degrees")
Arm.Arm_serial_servo_write6(90, 90, 90, 90, 90, 90, 1000)
time.sleep(1)

print("Done!")
