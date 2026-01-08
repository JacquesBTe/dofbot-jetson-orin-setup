# DOFBOT on Jetson Orin Nano Setup Guide

Complete guide for running Yahboom DOFBOT robot arm on NVIDIA Jetson Orin Nano 8GB with ROS 1 Noetic via Docker.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## ⚠️ Legal Notice

**The `yahboom_backup` folder is NOT included in this repository.** 

It contains proprietary Yahboom software that must be extracted from your original SD card. See [Extracting Yahboom Files](docs/02-extracting-yahboom-files.md) for instructions.

This repository only contains:
- Documentation on how to set up the system
- Docker configuration files  
- Example scripts that use the Yahboom library (but not the library itself)

**Users must legally own a DOFBOT kit to use this guide.**

---

## 🚨 Problem Statement

Yahboom's DOFBOT comes with a system image for the **original Jetson Nano (Tegra210)**, which is incompatible with the newer **Jetson Orin Nano (Tegra234)**. Additionally:

- The provided image uses ROS Melodic (Ubuntu 18.04)
- JetPack 6.x requires Ubuntu 22.04
- ROS Melodic is not available for Ubuntu 22.04
- Hardware interfaces (I2C buses) differ between Jetson Nano and Orin Nano

## ✅ Solution Overview

We use **Docker** to run ROS 1 Noetic in an isolated Ubuntu 20.04 environment while maintaining full hardware access to the Jetson Orin Nano's GPIO and I2C interfaces.

## 📋 Prerequisites

- NVIDIA Jetson Orin Nano 8GB
- JetPack 6.x installed (Ubuntu 22.04)
- DOFBOT robot arm kit from Yahboom
- Original Yahboom SD card image (for extracting software)
- USB SD card reader
- Basic Linux terminal knowledge

## 🚀 Quick Start
```bash
# 1. Clone this repository
git clone https://github.com/yourusername/dofbot-jetson-orin-setup
cd dofbot-jetson-orin-setup

# 2. Extract Yahboom software from your original SD card
# See docs/02-extracting-yahboom-files.md for detailed instructions

# 3. Run automated setup
./scripts/setup.sh

# 4. Start the Docker container
./scripts/start_container.sh

# 5. Inside Docker, fix I2C configuration
./scripts/fix_i2c.sh

# 6. Test the arm
python3 /root/examples/test_arm.py
```

## 📚 Documentation

Follow the guides in order:

1. [Hardware Setup](docs/01-hardware-setup.md) - Physical connections
2. [Extracting Yahboom Files](docs/02-extracting-yahboom-files.md) - Get software from original SD card
3. [Software Setup](docs/03-software-setup.md) - Docker and ROS installation
4. [I2C Configuration Fix](docs/03-i2c-fix.md) - **Critical hardware fix**
5. [Examples](examples/) - Sample programs and demos

## 🔑 Key Insight - The Critical I2C Fix

The servo controller is on **I2C bus 7** on Orin Nano, but Yahboom's code expects **bus 1**:
```python
# In Arm_Lib.py, change line 11:
self.bus = smbus.SMBus(1)  # ❌ Old Jetson Nano
# to:
self.bus = smbus.SMBus(7)  # ✅ Jetson Orin Nano
```

This single-line fix is automated in `scripts/fix_i2c.sh`

## 🎯 What Works

- ✅ Full 6-DOF arm control (all servos)
- ✅ Camera access and OpenCV integration
- ✅ Face detection and tracking
- ✅ Gamepad/joystick control
- ✅ All Yahboom demo programs
- ✅ ROS nodes and services
- ✅ Python API for custom programs

## 🗂️ Repository Structure
```
dofbot-jetson-orin-setup/
├── README.md                    # This file
├── docs/                        # Detailed documentation
│   ├── 01-hardware-setup.md
│   ├── 02-extracting-yahboom-files.md
│   └── 03-i2c-fix.md
├── docker/                      # Docker configuration
│   ├── Dockerfile
│   └── docker-compose.yml
├── scripts/                     # Automation scripts
│   ├── setup.sh                # Complete setup automation
│   ├── start_container.sh      # Launch Docker container
│   └── fix_i2c.sh              # Apply I2C fix
└── examples/                    # Sample programs
    ├── test_arm.py             # Quick hardware test
    └── basic_control.py        # Servo control examples
```

## 🐳 Why Docker?

- **Compatibility**: Run ROS 1 Noetic on Ubuntu 22.04 system
- **Isolation**: Doesn't interfere with JetPack installation  
- **Reproducibility**: Same environment every time
- **Easy cleanup**: Remove container if issues arise
- **Hardware access**: Full access to GPIO, I2C, camera

## ⚠️ Known Issues & Limitations

1. **I2C bus difference** - Fixed by changing bus 1 → 7 (automated)
2. **Jupyter notebooks** - Must convert to .py scripts: `jupyter nbconvert --to python notebook.ipynb`
3. **Performance overhead** - Docker adds ~5% overhead (negligible for robot control)
4. **Display apps** - Require `xhost +local:docker` before running

## 🔧 Troubleshooting

### "I2C error" messages
```bash
# Inside Docker, check I2C bus:
i2cdetect -y -r 7
# Should show device at 0x15

# Apply fix:
./scripts/fix_i2c.sh
```

### Camera not detected
```bash
# Check camera:
ls /dev/video*

# Inside Docker, test:
python3 -c "import cv2; print(cv2.VideoCapture(0).isOpened())"
```

### Servo not moving
```bash
# Check power to DOFBOT (12V adapter must be connected)
# Verify torque is enabled in code:
Arm.Arm_serial_set_torque(1)
```

For more issues, see [Troubleshooting Guide](docs/troubleshooting.md)

## 🤝 Contributing

Found an issue or improvement?
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

Or simply open an issue!

## 📄 License

MIT License - See [LICENSE](LICENSE) file for details

## 🙏 Acknowledgments

- **Yahboom** for the DOFBOT hardware and original software
- **NVIDIA** for Jetson platform and JetPack SDK
- **ROS Community** for excellent robotics framework
- **Docker** for containerization technology

## 📧 Support

- **Issues**: Open a GitHub issue
- **Discussions**: Use GitHub Discussions for questions
- **Email**: [your-email@example.com]

## 🌟 Star This Repo!

If this guide helped you, please star the repository to help others find it!

---

**Disclaimer**: This is a community guide and is not officially supported by Yahboom or NVIDIA. Use at your own risk.
