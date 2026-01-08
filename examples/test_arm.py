#!/usr/bin/env python3
"""Quick test to verify arm is working"""
import sys
import time
sys.path.append('/root/yahboom_backup/Dofbot/0.py_install')
from Arm_Lib import Arm_Device

print("🤖 Testing DOFBOT...")
Arm = Arm_Device()
time.sleep(0.5)

Arm.Arm_serial_set_torque(1)
print("✅ Torque enabled")

print("📍 Moving to home position...")
Arm.Arm_serial_servo_write6(90, 90, 90, 90, 90, 90, 1000)
time.sleep(2)

print("👋 Waving...")
for i in range(2):
    Arm.Arm_serial_servo_write(1, 60, 500)
    time.sleep(0.6)
    Arm.Arm_serial_servo_write(1, 120, 500)
    time.sleep(0.6)

Arm.Arm_serial_servo_write(1, 90, 500)
print("✅ Test complete! Arm is working!")
