# Signals GitHub Workflows

This directory contains the GitHub Actions workflows that automate the project's testing, building, and deployment processes.

## Workflows

### [tests.yml](file:///Users/rodydavis/Developer/signals.dart/.github/workflows/tests.yml)
The primary CI pipeline triggered on every push and pull request.
- **Environment**: Runs on `ubuntu-latest`.
- **Steps**:
    - Installs Dart and Flutter.
    - Activates **Melos** for monorepo management.
    - Runs `melos bootstrap` to link local packages.
    - Executes **Static Analysis** (`melos run analyze`).
    - Executes **Unit/Widget Tests** (`melos run test`).

### [website.yml](file:///Users/rodydavis/Developer/signals.dart/.github/workflows/website.yml)
Automates the deployment of the [dartsignals.dev](https://dartsignals.dev) documentation.
- **Trigger**: Runs on every push to the `main` branch.
- **Tools**: Uses `Astro` with `pnpm` to build the static documentation site.
- **Deployment**: Deploys the built output to **GitHub Pages**.

### [build.yml](file:///Users/rodydavis/Developer/signals.dart/.github/workflows/build.yml)
Contains general build validation steps for the monorepo packages.
