# AI Agent Rules - Package Versioning & Changelog Updates

This file defines critical rules and workflows that all AI coding agents working on the `signals.dart` repository must follow.

---

## 📋 Rule: Version and Changelog Updates

Whenever you make code changes (bug fixes, refactoring, new features, or breaking changes) inside any package in the `./packages/` directory, you **must** update both the package's version and its changelog.

### 1. Update the Changelog (`CHANGELOG.md`)
*   Every modified package must have a new entry in its `CHANGELOG.md`.
*   The entry must contain a human-readable list of changes, categorized clearly (e.g., Added, Fixed, Changed, Removed).
*   The version header in the changelog must match the new version declared in `pubspec.yaml`.

### 2. Update the Package Version (`pubspec.yaml`)
You must increment the package's version in its `pubspec.yaml` according to the principles of Semantic Versioning (SemVer):

*   **PATCH (`0.0.1` -> `0.0.2`):**
    *   *Trigger:* Backward-compatible bug fixes, refactoring, performance improvements, documentation updates, or dependency bumps.
*   **MINOR (`0.1.0` -> `0.2.0`):**
    *   *Trigger:* Backward-compatible new features, addition of new public APIs, classes, helper methods, or non-breaking extensions.
*   **MAJOR (`1.0.0` -> `2.0.0`):**
    *   *Trigger:* Backward-incompatible / breaking public API changes, removal of deprecated APIs, or fundamental architectural shifts.

---

## 🔄 Checklists & Verification for Agents

- [ ] Identify which packages in `./packages/` were modified.
- [ ] Determine the SemVer bump type (Patch, Minor, or Major) based on the nature of the changes.
- [ ] Increment the `version` field in each modified package's `pubspec.yaml`.
- [ ] Add a corresponding release section at the top of each package's `CHANGELOG.md` detailing the changes.
- [ ] Run `melos bootstrap` (or `flutter pub get`) to ensure the updated packages resolve and inter-link cleanly.
- [ ] Group both the code changes, `pubspec.yaml` updates, and `CHANGELOG.md` updates in the same git commit.
