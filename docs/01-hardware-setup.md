# Hardware Setup

## Assembly
1. Assemble DOFBOT following Yahboom instructions
2. Connect expansion board to Jetson 40-pin GPIO
3. Connect 12V power to DOFBOT (separate from Jetson)
4. Optional: Connect camera to CSI port

## Power Requirements
- **Jetson Orin Nano**: USB-C PD (15W+) or 19V barrel jack
- **DOFBOT**: 12V/2A power adapter (included with kit)

## Connections
- GPIO: All pins connected via expansion board
- I2C: Servo controller uses I2C bus 7
- Camera: CSI connector (if using vision features)

Next: [Software Setup](02-software-setup.md)
