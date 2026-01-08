# Extracting Yahboom Files

## Why You Need This

The Yahboom software is proprietary and cannot be redistributed. You must extract it from your original Yahboom SD card.

## What You Need
- Original Yahboom DOFBOT SD card (came with your kit)
- USB SD card reader
- Your Jetson Orin Nano

## Steps

### 1. Insert Yahboom SD Card
```bash
# Insert the SD card via USB reader
lsblk
# Look for your SD card (usually /dev/sda)
```

### 2. Mount the Card
```bash
# Create mount point
sudo mkdir -p /media/yahboom

# Mount (replace sda1 with your actual device)
sudo mount /dev/sda1 /media/yahboom

# Verify
ls /media/yahboom/home/jetson
# Should see: catkin_ws, Dofbot, Arm, etc.
```

### 3. Copy Software
```bash
# Create backup directory
mkdir -p ~/yahboom_backup

# Copy ROS workspace
cp -r /media/yahboom/home/jetson/catkin_ws ~/yahboom_backup/
cp -r /media/yahboom/home/jetson/dofbot_ws ~/yahboom_backup/

# Copy Python libraries
cp -r /media/yahboom/home/jetson/Dofbot ~/yahboom_backup/
cp -r /media/yahboom/home/jetson/Arm ~/yahboom_backup/
cp -r /media/yahboom/home/jetson/oled_yahboom ~/yahboom_backup/

# Copy kinematics library
cp /media/yahboom/home/jetson/libdofbot_kinemarics.so ~/yahboom_backup/

# Optional: Copy AI models
cp -r /media/yahboom/home/jetson/jetson-inference ~/yahboom_backup/ 2>/dev/null || true
```

### 4. Verify Files
```bash
# Check structure
ls -la ~/yahboom_backup/

# Should see:
# - catkin_ws/        (ROS workspace)
# - dofbot_ws/        (Alternative ROS workspace)
# - Dofbot/           (Python demos and examples)
# - Arm/              (Arm control library)
# - oled_yahboom/     (OLED display support)
# - libdofbot_kinemarics.so (Kinematics library)
```

### 5. Unmount SD Card
```bash
sudo umount /media/yahboom
```

## File Structure Explained
```
yahboom_backup/
├── catkin_ws/          # ROS 1 workspace with arm control packages
│   └── src/
│       ├── arm_face_follow/
│       ├── arm_color_grab/
│       └── ...
├── Dofbot/            # Main demos and examples
│   ├── 0.py_install/  # Python library installation
│   │   └── Arm_Lib/   # Core arm control library
│   ├── 1.telecontrol/ # Manual control demos
│   ├── 3.ctrl_Arm/    # Servo control notebooks
│   └── 5.AI_Visual/   # Computer vision demos
├── Arm/               # Standalone arm utilities
└── libdofbot_kinemarics.so  # Forward/inverse kinematics
```

## Important Files

**Must have:**
- `Dofbot/0.py_install/Arm_Lib/` - Core control library
- `catkin_ws/` - ROS packages
- `libdofbot_kinemarics.so` - Kinematics

**Optional but useful:**
- `Dofbot/5.AI_Visual/` - Face tracking, object detection
- `Dofbot/3.ctrl_Arm/` - Control examples

## Troubleshooting

**"Permission denied" errors:**
```bash
sudo chown -R $USER:$USER ~/yahboom_backup
```

**SD card not detected:**
```bash
# Check USB connection
lsusb
# Try different USB port
```

**Partial copy:**
Some files may fail - that's okay. The critical ones are:
1. `Arm_Lib/`
2. `catkin_ws/src/`

Next: [Docker Setup](03-docker-setup.md)
