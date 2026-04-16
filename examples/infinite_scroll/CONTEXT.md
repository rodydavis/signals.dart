# Infinite Scroll Example

This example demonstrates how to implement a paginated list using **`AsyncSignal`** and custom data source abstractions.

## Core Concepts

### [DataSource](file:///Users/rodydavis/Developer/signals.dart/examples/infinite_scroll/lib/main.dart)
The generic `DataSource<T>` class extends `AsyncSignal<List<T>>`.
- **State Management**: It holds the aggregate list of all items fetched so far.
- **Pagination Logic**: Tracks the current `page` signal and computes `hasMore`.
- **Atomic Updates**: Uses **`batch()`** when updating multiple signals (e.g., setting the new page and appending items) to prevent redundant UI rebuilds during the transition.

### Asynchronous Flow
- **`checkForMore()`**: A guarded method that ensures only one fetch operation happens at a time by checking `value.isLoading`.
- **Error Handling**: Uses `AsyncState.error` to propagate exceptions from the data layer directly to the UI for automatic handling.

## UI Implementation

### [InfiniteScroll Widget](file:///Users/rodydavis/Developer/signals.dart/examples/infinite_scroll/lib/main.dart)
Uses **`Watch.builder`** to reactively render the list.
- **Surgical Updates**: Only the list view rebuilds as new items are appended.
- **Scroll Integration**: The `ListView.builder` triggers `source.checkForMore()` when the user reaches the bottom of the list, creating a seamless "infinite" experience.
- **Map Utility**: Demonstrates using `source.value.maybeMap` to handle loading and error states within a single reactive block.
