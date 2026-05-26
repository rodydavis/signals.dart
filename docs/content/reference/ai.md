---
title: AI Integration
description: Enable LLMs and AI coding assistants to build high-performance reactive systems using Signals.dart.
---

The Signals ecosystem is designed to be highly accessible for Large Language Models (LLMs) and AI coding assistants. We provide unified context streams and modular developer **Skills** to give AI assistants full mastery over the framework's reactive paradigms.

---

## Unified Context Endpoint

Instead of manually feeding individual files into your AI chat or workspace, you can reference our single-source-of-truth endpoints. They contain the entire documentation set concatenated into a structured Markdown stream:

| Endpoint | Contents | Best Use Case |
| :--- | :--- | :--- |
| **`https://dartsignals.dev/llms.txt`** | Full user guides and core reference documentation. | Adding project context to lightweight assistants. |
| **`https://dartsignals.dev/llms-full.txt`** | Complete, comprehensive reference manual (expanded details). | In-depth code generation and technical codebases. |

### Adding to Local Workspace Context
If your AI coding assistant is scoped to your local project directory, you can download the endpoint directly to your workspace:

```bash
curl https://dartsignals.dev/llms.txt > signals.md
```

Once downloaded to your project root, you can reference the file (e.g. using `@signals.md` in cursor/copilot) to supply instant, highly relevant context.

---

## Prepackaged AI Developer Skills

To enable AI agents and coding assistants to write clean, idiomatic code for version 7 of the reactive framework, we package modular, high-fidelity developer **Skills** in the repository under the `/skills` folder.

These skills act as a system prompt extension that teaches the AI best practices, common gotchas (like the async tracking gap), and lifecycle optimization tracks:

* **`signals-preact-dart`**: Deep knowledge of the core reactive primitives (`signal`, `computed`, `effect`, `batch`, `untracked`).
* **`signals-dart`**: Best practices for async signal operations (`FutureSignal`, `StreamSignal`), reactive collections, writable computed signals (`linkedSignal`), and value semantics.
* **`signals-flutter`**: Comprehensive guides on element-level reactive UI integration, high-frequency GPU rendering bypasses, lifecycle side-effects, and `.watch(context)` extensions.
* **`signals-migration-6-to-7`**: Detailed instructions, patterns, and refactoring techniques to safely upgrade applications from signals v6.x to v7.0.0.

### One-Command Skill Installation
You can instantly install all available signals skills into your local AI workspace using the unified `skills.sh` registry CLI:

```bash
npx skills add rodydavis/signals.dart
```

This makes the skills immediately discoverable and usable by any editor-based or terminal-based AI assistant.
