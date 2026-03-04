# Release Notes: dev1

**Release Date:** February 22, 2026
**Branch:** `dev`
**Tag:** `dev1`

## Summary
- Refactored high-complexity methods in RFIDHandler.java for maintainability.
- Updated flow_design.md and state_diagram.mmd to match the latest integrated test logic.
- Regenerated state_diagram.png from Mermaid source.
- Improved documentation and code clarity.

## Details
- Refactored setTriggerEnabled, eventStatusNotify, and verifyWriteTagWithRetry to reduce cognitive complexity.
- Replaced duplicated EPC values with EPC_TEST_DATA constant.
- Updated and clarified the state diagram in both Mermaid and PNG formats.
- flow_design.md now references the latest diagram and logic.
- All changes pushed to dev branch.

## Commit History (last 10)
- a268aaf Update flow_design.md, state_diagram.mmd, and regenerate state_diagram.png to match latest integrated test logic and code refactor
- c048113 Update state_diagram.png from Mermaid source
- de83200 Fix state diagram failure message formatting
- bc76a0c Refactor state diagram for clarity
- 338eca6 Refactor state diagram for clarity and formatting
- 1faeb13 Align flow_design diagram section with rendered PNG docs assets
- 68b10db Add rendered state diagram image to README docs
- 0123300 Add integrated test flow Mermaid state diagram to README
- ffba25d Fix build by enforcing Java 17 and aligning app compile target
- 09825fc Update integrated flow markdown

---
Tag: dev1
