#!/bin/bash
# Fix I2C bus configuration (run inside Docker)

echo "🔧 Fixing I2C bus configuration..."

# Install Arm library
cd /root/yahboom_backup/Dofbot/0.py_install
pip3 install -e .

# Fix smbus import
sed -i 's/import smbus$/import smbus2 as smbus/' Arm_Lib/Arm_Lib.py

# THE CRITICAL FIX - Change I2C bus from 1 to 7
sed -i 's/self.bus = smbus.SMBus(1)/self.bus = smbus.SMBus(7)/' Arm_Lib/Arm_Lib.py

# Verify changes
echo ""
echo "Verifying fixes:"
grep "import smbus" Arm_Lib/Arm_Lib.py
grep "self.bus = smbus" Arm_Lib/Arm_Lib.py

echo ""
echo "✅ I2C configuration fixed!"
echo "   Bus changed: 1 → 7"
