---
name: increase-coverage
description: Systematic guidelines for executing code coverage tools, analyzing gaps in testing, and implementing targeted tests to maximize code coverage across the reactive framework.
---

# Code Coverage Execution and Maximization Guide

This developer skill provides step-by-step instructions and best practices for executing code coverage tools, identifying untested paths (gaps), and writing high-fidelity unit tests to drive coverage to 100% across the monorepo.

---

## 1. Executing and Aggregating Monorepo Coverage

Our monorepo coordinates testing across multiple packages using Melos. Follow this command workflow to generate and merge coverage data:

### A. Run Package Tests with Coverage
Execute the monorepo test runner. This runs `flutter test --coverage` (or `dart test --coverage`) across all packages:
```bash
melos run test
```

### B. Combine Package Coverage Files
Run the combination script to merge individual package-level `coverage/lcov.info` files into a unified root `lcov.info` file:
```bash
melos run coverage
```
> [!NOTE]
> The aggregation script (`scripts/combine_coverage.sh`) dynamically rewrites path roots to be absolute and deletes temporary package `coverage` directories to maintain workspace hygiene.

### C. Generate the HTML Coverage Report
Translate the unified `lcov.info` file into an interactive HTML visualization report using `genhtml` (part of the `lcov` toolkit):
```bash
genhtml lcov.info -o coverage/html
```

---

## 2. Pinpointing Uncovered Lines (Gap Analysis)

To quickly locate untested lines of code without browsing the entire HTML report, run the following `grep` and `awk` pipeline on the root `lcov.info` file:

```bash
grep -E "SF:|DA:" lcov.info | awk -F: '/SF/ {file=$2} /DA/ {split($2,a,","); if(a[2]==0) print file, a[1]}'
```

This output displays the absolute file path followed by the exact line number of every uncovered statement, for example:
```text
/workspace/packages/preact_signals/lib/src/model.dart 21
/workspace/packages/preact_signals/lib/src/model.dart 25
```

---

## 3. Strategies for Reaching 100% Coverage

Once you identify the uncovered lines, apply these targeted testing strategies to write meaningful tests:

### A. Testing Model and Option Basics
Ensure value models, options, and parameters are fully exercised:
- **`copyWith` Methods**: Test with both `null` (to assert fallback to current value) and explicit values.
- **Equality (`==`) and `hashCode`**:
  - Test comparing identical references (`identical(this, other)`).
  - Test comparing distinct instances with identical properties (expect equal).
  - Test comparing distinct instances with differing properties (expect unequal).
  - Test comparing against null or instances of completely different classes.

### B. Exercising Complex Branch/Condition Logic
Examine every nested `if`, `else`, and ternary (`? :`) statement:
- Construct test inputs that force the path to evaluate to `true`.
- Construct test inputs that force the path to evaluate to `false`.
- Ensure bounds checks, empty collections, and null-safety fallbacks are explicitly triggered.

### C. Simulating and Asserting Exception/Catch Paths
To cover recovery logic or diagnostic assertions:
- **`catch` Blocks**: Pass incompatible types or construct scenarios that cause runtime `TypeError` or `AssertionError` to verify fallback branches.
- **Dispose and Lifecycle Errors**: Call `.dispose()` on a signal/primitive, then attempt a read or write operation to assert it throws `SignalsReadAfterDisposeError` or `SignalsWriteAfterDisposeError`.

### D. Deep Recursive Collections
Verify that custom deep collection assertions (such as lists, maps, sets, or nested objects) evaluate both matching and mismatching configurations at every depth.

---

## 4. Housekeeping and Version Safety

Before finalizing the coverage maximization run, verify repository hygiene:

1. **Format test files**:
   ```bash
   dart format .
   ```
2. **Run Lints & Static Analysis**:
   ```bash
   melos run analyze
   ```
3. **Clean Git State**:
   Never check coverage files (`lcov.info` or `coverage/`) into Git history. If they are accidentally staged, remove them:
   ```bash
   git rm -r --cached coverage/
   git rm lcov.info
   ```
