# Software Setup

## Prerequisites
- JetPack 6.x installed on Jetson Orin Nano
- Docker installed (included with JetPack)
- Original Yahboom SD card

## Quick Setup
```bash
git clone https://github.com/JacquesBTe/dofbot-jetson-orin-setup
cd dofbot-jetson-orin-setup
./scripts/setup.sh
./scripts/start_container.sh
```

## Inside Docker
```bash
./scripts/fix_i2c.sh
python3 /root/examples/test_arm.py
```

Next: [I2C Configuration](03-i2c-fix.md)
