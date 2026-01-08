# Initial Setup

## Hardware Assembly

1. **Assemble DOFBOT** following Yahboom's instructions
2. **Connect to Jetson Orin Nano**:
   - Connect DOFBOT expansion board to Jetson's 40-pin GPIO header
   - Ensure power connection (DOFBOT needs separate 12V power supply)
   - Connect camera to CSI port (if using)

## JetPack Installation

1. Download JetPack 6.x SDK from NVIDIA:
```bash
   # Visit: https://developer.nvidia.com/embedded/jetpack
```

2. Flash SD card with official image (not Yahboom's image)

3. Boot and complete Ubuntu setup

4. Verify JetPack version:
```bash
   cat /etc/nv_tegra_release
   # Should show: R36.x (JetPack 6.x)
```

## Initial System Update
```bash
sudo apt update
sudo apt upgrade -y
sudo reboot
```

## Install Docker
```bash
# Docker should already be installed on JetPack 6.x
docker --version

# If not installed:
sudo apt install docker.io -y
sudo usermod -aG docker $USER
newgrp docker
```

## Mount Yahboom SD Card
```bash
# Insert Yahboom's original SD card via USB adapter
lsblk  # Find the device (usually /dev/sda1)

# Create mount point
sudo mkdir -p /media/yahboom
sudo mount /dev/sda1 /media/yahboom

# Verify files are accessible
ls /media/yahboom/home/jetson
```

Next: [Extracting Yahboom Files](02-extracting-yahboom-files.md)
