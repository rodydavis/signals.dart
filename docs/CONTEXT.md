# Jaspr Documentation Web App

This is a Dart-based static website package built using the Jaspr framework to generate and render the documentation for the `signals.dart` reactive framework.

## Project Structure

- **[lib/](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/build-signals-reactive-framework/docs/lib/CONTEXT.md)**: Main client/server entrypoints and options.
- **[bin/](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/build-signals-reactive-framework/docs/bin/)**: Build scripts and execution entrypoints.
- **[web/](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/build-signals-reactive-framework/docs/web/)**: Static web assets, favicon, styles, and raw markdown source directories.
- **[content/](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/build-signals-reactive-framework/docs/content/)**: Site structure, data files, route configuration, and reference documents.

## Configuration & Tooling

- **`pubspec.yaml`**: Lists dependencies including `jaspr`, `jaspr_content`, and `jaspr_router` with configuration setting `jaspr.mode: static` to build static files.
- **`analysis_options.yaml`**: Strict static analysis guidelines for Jaspr components.

## Build and Preview Workflow

1. **Regenerate API references**:
   ```bash
   dart scripts/generate_docs.dart
   ```
2. **Build static site**:
   ```bash
   jaspr build
   ```
3. **Local development preview**:
   ```bash
   jaspr serve
   ```
