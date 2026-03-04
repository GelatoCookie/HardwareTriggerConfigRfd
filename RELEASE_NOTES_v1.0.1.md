# Release Notes

Initial commit.

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

