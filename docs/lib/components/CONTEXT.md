# Jaspr Documentation Site Components

This directory houses individual Jaspr UI components used to render the documentation layouts, markdown code blocks, and site navigation.

## Component Overview

- **`clicker.dart`**: A simple reactive counter button demonstrating basic signals integration within a Jaspr component.
- **`copy_markdown.dart`**: Component providing a convenient "Copy Code" utility block overlay for raw markdown blocks.
- **`navigation.dart`**: The primary navigation drawer sidebar. It defines the structured navigation tree matching all packages, classes, and guides. Generated automatically by the documentation generator script.
- **`safe_code_block.dart`**: A wrapper component to safely render multi-line code blocks and prevent parsing/encoding issues during Jaspr's static build.

## Relationships

- **Routing**: Integrates with `jaspr_router` to dynamically update active classes on navigation items matching current URL paths.
- **Auto-generation**: `navigation.dart` is maintained programmatically by running `dart scripts/generate_docs.dart`, keeping the navigation tree in sync with the codebase API.
