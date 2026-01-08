#!/bin/bash
# Automated DOFBOT setup script for Jetson Orin Nano

set -e

echo "🤖 DOFBOT Jetson Orin Nano Setup"
echo "================================="

# Check if running on Jetson
if [ ! -f /etc/nv_tegra_release ]; then
    echo "❌ This script must run on a Jetson device"
    exit 1
fi

echo "✅ Detected Jetson device"

# Check for Yahboom SD card
if [ ! -d /media/yahboom ]; then
    echo "📋 Please mount Yahboom SD card first:"
    echo "   sudo mkdir -p /media/yahboom"
    echo "   sudo mount /dev/sda1 /media/yahboom"
    exit 1
fi

echo "✅ Yahboom SD card found"

# Backup Yahboom files
echo "📦 Backing up Yahboom software..."
mkdir -p ~/yahboom_backup
cp -r /media/yahboom/home/jetson/catkin_ws ~/yahboom_backup/ 2>/dev/null || true
cp -r /media/yahboom/home/jetson/dofbot_ws ~/yahboom_backup/ 2>/dev/null || true
cp -r /media/yahboom/home/jetson/Dofbot ~/yahboom_backup/ 2>/dev/null || true
cp -r /media/yahboom/home/jetson/Arm ~/yahboom_backup/ 2>/dev/null || true
cp /media/yahboom/home/jetson/libdofbot_kinemarics.so ~/yahboom_backup/ 2>/dev/null || true

echo "✅ Files backed up to ~/yahboom_backup"

# Build Docker image
echo "🐳 Building Docker image..."
cd ~/dofbot-jetson-orin-setup/docker
docker build -t dofbot_ros .

echo "✅ Docker image built"

echo ""
echo "🎉 Setup complete!"
echo ""
echo "Next steps:"
echo "1. Run: ./scripts/start_container.sh"
echo "2. Inside container, run: ./scripts/fix_i2c.sh"
echo "3. Test with: python3 /root/scripts/test_arm.py"
