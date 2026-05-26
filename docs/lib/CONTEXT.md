# Jaspr Docs Library Source

This directory contains the main application logic and dual-entrypoints for the static-compiled Jaspr documentation site.

## Directory Structure & Files

- **`main.client.dart`**: The client-side entrypoint. Responsible for bootstrapping the Jaspr application on the client and attaching listeners/routers.
- **`main.client.options.dart`**: Compilation options and generated assets configurations for the client build pipeline.
- **`main.server.dart`**: The server-side entrypoint. Handles pre-rendering, static HTML file generation, and routing configurations during the `jaspr build` process.
- **`main.server.options.dart`**: Server compilation and build runner configuration settings.
- **[components/](file:///Users/rodydavis/.gemini/antigravity/worktrees/signals.dart/build-signals-reactive-framework/docs/lib/components/)**: Reusable UI components used to render the documentation layout, navigation trees, and code blocks.

## Relationships & Integrations

- **Pre-rendering**: Uses Jaspr's static pre-rendering mode to crawl routes and generate optimized, search-engine-friendly static HTML files.
- **Client Hydration**: Client-side options bind dynamically to interactive components to enable responsive client transitions.
