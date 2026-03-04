# Release Notes – v1.0.1

**Date:** February 20, 2026
**Repository:** https://github.com/GelatoCookie/HardwareTriggerSwitch_RFID_Barcode_RFD_BT

---

## What’s New in v1.0.1

- **Refactored Strings:**
  - All test result and prompt messages moved to strings.xml for localization and maintainability.
  - EPC test data is now a constant, reducing duplication.

- **Retry Logic:**
  - Added robust retry handling for failed tag verification.
  - User is prompted to retry on failure, with retry count support and clear UI feedback.

- **Flow Diagram Improvements:**
  - Updated flow_design.md diagram to show retry loop for failed verification.
  - Documentation now matches code logic for reliability and user experience.

- **Code Quality:**
  - Improved readability and maintainability.
  - No type errors found; complexity and exception handling flagged for future refactoring.

---

## How to Use
1. Build and deploy the app to a Zebra RFD40 device.
2. Select integrated test mode in the UI.
3. Follow prompts for RFID read, barcode scan, tag write, and verification.
4. On failure, retry is supported with clear UI feedback.

---

## References
- See `RFIDHandler.java` for implementation details.
- See `strings.xml` for all user-facing messages.
- See `flow_design.md` for updated state diagram.

---

## Upgrade Instructions
- Pull the latest changes from the repository.
- Tag v1.0.1 is available for checkout and deployment.
- For the latest development release, see `RELEASE_NOTES_dev1.md` (tag `dev1`).

---

## Additional Update (2026-02-21)
- Optimize timing for wait for reader idle using polling (`500ms x 10`) instead of fixed delay.
- This keeps timeout bounded while reducing unnecessary waits when reader idle is reached early.

## Patch Entry (2026-02-21)
- Commit: `c319551`
- Branch: `dev`
- Summary:
  - Added in-code comments for "optimize timing for wait for reader idle".
  - Replaced fixed waiting path with bounded polling behavior (`500ms x 10`).
  - Updated project Markdown documentation to reflect timing optimization and behavior.

