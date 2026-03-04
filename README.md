# Zebra RFD40 Integrated Test Demo

This project demonstrates a robust state-machine approach for integrated RFID and Barcode operations on the Zebra RFD40 reader, focusing on the `test_read_write_verify` workflow.

## Features
- Seamless transition between RFID inventory and Barcode scan using a single hardware trigger
- Synchronous RFID tag write and verification using barcode input
- Robust state management to prevent race conditions and ensure reliable hardware configuration

## Key Concepts
- **bRfidBusy**: Indicates if the RFID engine is active (prevents mode/config changes during inventory)
- **bSwitchFromRfidToBarcode**: Guards against RFID trigger events during barcode mode
- **setTriggerEnabled(isRfidEnabled)**: Safely reconfigures the hardware trigger between RFID and Barcode (SLED_SCAN) modes

## Test Flow: `test_read_write_verify`

1. **RFID Read (Initial State)**
    - User initiates test from UI
    - Pull trigger: Starts RFID inventory (`bRfidBusy = true`)
    - Release trigger: Stops inventory (`bRfidBusy = false`)
2. **Transition to Barcode Input**
    - On inventory stop, set `bSwitchFromRfidToBarcode = true`
    - Disable RFID trigger events
    - Call `setTriggerEnabled(false)` to switch to Barcode mode
    - UI prompts user to scan barcode
3. **Barcode Scan & RFID Write/Verify**
    - Pull trigger: Barcode scan (no RFID event)
    - Barcode data received in UI
    - Call `testWriteTag()` to write barcode data to tag (synchronous)
    - Call `verifyWriteTag()` to confirm write
4. **Restoration to RFID Mode**
    - On success, reset test flag
    - Call `setTriggerEnabled(true)` to restore RFID mode
    - Reset `bSwitchFromRfidToBarcode`

### State Diagram

![Integrated Test State Diagram](docs/images/state_diagram.png)

Source: `docs/images/state_diagram.mmd`

## Reliability Features
- All hardware mode switches are gated by `bRfidBusy` checks
- Guard flags prevent accidental or duplicate trigger events during transitions
- Synchronous tag access ensures precise write/verify operations

## File Overview
- `app/src/main/java/com/zebra/rfid/demo/sdksample/RFIDHandler.java`: Core handler for RFID/Barcode logic and state management
- `app/readRfid_switchBarcodeandScan_writeRfid_verifyRFID_RestoreRfid.md`: Detailed design flow and state diagram
- `app/summary.md`: High-level summary of the integrated test logic

## Getting Started
1. Build and deploy the app to a Zebra RFD40 device
2. From the UI, select the integrated test mode
3. Follow on-screen prompts to:
    - Pull trigger to inventory
    - Scan barcode
    - Wait for tag write/verify
    - Observe automatic restoration to RFID mode

## License
See LICENSE for details.

## Release Notes
- Latest release tag: `dev1`
- See `RELEASE_NOTES_dev1.md` for release summary and scope.

## Update Note (2026-02-21)
- Optimize timing for wait for reader idle by using polling (`500ms x 10`) instead of a fixed sleep.
- This reduces unnecessary wait time when the reader becomes idle earlier and keeps a bounded timeout.
