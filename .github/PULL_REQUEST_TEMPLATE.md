
# Pull Request Template

**Release: dev1**

See `RELEASE_NOTES_dev1.md` for the latest release details.

## Description
Summary of the change and which issue is fixed.

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Code style/formatting
- [ ] Other

## Checklist
- [ ] My code follows the style guidelines
- [ ] I have performed a self-review
- [ ] I have commented my code
- [ ] I have made corresponding documentation changes
- [ ] My changes generate no new warnings
- [ ] I have added tests or proven my feature works
- [ ] All tests pass locally

## Related Issues
Link to related issues or PRs

## Update Note (2026-02-21)
- Includes optimization timing change for wait-for-reader-idle (`500ms` polling with bounded retries).
