# Zebra RFD40 Integrated Test Demo

This Android app demonstrates an integrated test mode for Zebra RFD40 RFID readers, enabling seamless transitions between RFID inventory and barcode scanning using a single hardware trigger.

## Features
- RFID inventory and barcode scan with one trigger
- Synchronous RFID tag write and verification using barcode input
- Robust state machine logic to prevent race conditions
- Busy protection and guard flags for reliable operation
- UI feedback for test status and results

## Architecture
- **MainActivity**: UI, test mode control, and user interaction
- **RFIDHandler**: Manages RFID reader lifecycle, state machine, and trigger configuration
- **ScannerHandler**: Handles barcode scanner events and data
- State variables (`bRfidBusy`, `bSwitchFromRfidToBarcode`, test flags) coordinate transitions

## Design Flow
1. RFID Read (Inventory)
2. Transition to Barcode Mode
3. Barcode Scan & RFID Write/Verify
4. Restoration to RFID Mode

## Setup & Usage
- Build and deploy to Zebra RFD40 device
- Select integrated test mode in UI
- Follow prompts for RFID read, barcode scan, tag write, and verification

## Diagram
![Integrated Test State Diagram](docs/images/state_diagram.png)

For technical details, see `design.md` and source code in `app/src/main/java/com/zebra/rfid/demo/sdksample/`.

