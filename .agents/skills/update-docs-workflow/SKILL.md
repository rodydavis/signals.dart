---
name: update-docs-workflow
description: Review the current Jaspr docs, audit source code doc comments, edit the source code, and run the generator script to verify docs updates.
---

# Jaspr Documentation Audit and Regeneration Workflow

This skill provides a systematic and automated workflow to inspect generated Jaspr reference files, trace documentation back to its source Dart declarations, audit comments for completeness, enrich source comments with examples, and run the doc generator to verify static site updates.

## Objective
Ensure all public APIs across the monorepo have high-quality, comprehensive documentation comments (`///`) with functional usage examples and clean styling without placeholders.

> [!IMPORTANT]
> Focus exclusively on the `docs/` directory and Jaspr documentation site. Completely ignore the `website/` directory (which contains the legacy/alternative Astro configuration).

---

## 🛠️ Step-by-Step Workflow

### Step 1. Review Generated Markdown Docs
Locate the generated reference markdown files under the Jaspr docs tree:
```
docs/content/packages/
```
For example, check if specific pages under `preact_signals/`, `signals_core/`, or `signals_flutter/` are minimal, outdated, or contain empty blocks.

### Step 2. Trace to Source Declarations
Use the declaration name and package context from the markdown file to locate the corresponding source file under the package’s source tree:
- **preact_signals:** `packages/preact_signals/lib/src/`
- **signals_core:** `packages/signals_core/lib/src/`
- **signals_flutter:** `packages/signals_flutter/lib/src/`
- **signals_hooks:** `packages/signals_hooks/lib/src/`

### Step 3. Run the Programmatic Doc Comment Auditor
Execute the programmatic audit script to check for declarations lacking comments or examples:
```bash
dart /Users/rodydavis/.gemini/antigravity/brain/5f607010-d7ba-40da-b166-4b3c433388c9/scratch/analyze_doc_comments.dart
```

### Step 4. Enrich Dart Source Code Comments
Open the target source file and enrich the `///` comments on classes, functions, and extensions using the following standards:
- **Comprehensive Explanations:** Explain the reactive behavior, lazy calculation, memoization caching, or event subscription behaviors.
- **Comparative Code Examples:** Show sequential vs batched updating behaviors (like in `action.dart`), or standard vs custom equality logic.
- **XML-Style Callouts:** Use `<Info>`, `<Warning>`, `<Error>`, or `<Success>` XML tags inside comments rather than markdown triple-colon syntax (`:::`) to leverage Jaspr's custom callout components.

### Step 5. Run the Documentation Generator
Regenerate all markdown files and search indices by executing:
```bash
dart scripts/generate_docs.dart
```

### Step 6. Verify and Live Preview
1. **Analyze:** Run standard analysis on the `docs` package to check for any formatting warnings:
   ```bash
   dart analyze docs
   ```
2. **Build and Preview:** Launch the Jaspr build/serve commands inside the `docs/` folder:
   ```bash
   jaspr build
   ```
   Or run the development preview server:
   ```bash
   jaspr serve
   ```
   Open `http://localhost:8080/` in the browser to visually inspect the updated docs and ensure everything renders beautifully.
