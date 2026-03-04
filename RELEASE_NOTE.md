# Release Notes – v1.0.0

**Release Date:** March 4, 2026
**Tag:** v1.0.0

## Overview
This is the initial public release of the Zebra RFD40 Integrated Test Demo Android application.

## Features
- Integrated test mode for Zebra RFD40 RFID reader
- Seamless transition between RFID inventory and barcode scan using a single hardware trigger
- Synchronous RFID tag write and verification using barcode input
- Robust state machine logic for reliable hardware configuration
- Busy protection and guard flags to prevent race conditions
- UI feedback for test status and results

## Setup & Usage
- Build and deploy to Zebra RFD40 device
- Select integrated test mode in UI
- Follow prompts for RFID read, barcode scan, tag write, and verification

## Technical Highlights
- State-driven architecture (see design.md)
- Main classes: MainActivity, RFIDHandler, ScannerHandler
- Mermaid state diagram included in documentation

## Known Issues
- Deprecated Gradle features (see build warnings)
- FlatDir usage for AARs (future migration recommended)

## References
- See README.md and design.md for details
- Source code: app/src/main/java/com/zebra/rfid/demo/sdksample/
