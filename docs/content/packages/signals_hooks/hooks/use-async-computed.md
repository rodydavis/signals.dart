---
title: useAsyncComputed
description: Creates a new FutureSignal from a computed async value and subscribes to it.
---

Creates a new [FutureSignal](/types/futuresignal) from a computed async value and subscribes to it.

This hook allows you to construct an async computation that automatically reruns whenever its
reactive dependencies (e.g. other signals accessed via <code>.value</code>) or hook keys change.

<Success>
It combines the capabilities of computed/derived state with asynchronous futures, serving as a powerful
replacement for complex chain reactions of streams or state notifier combinations.
</Success>

### Parameters
- **value**: The async computation function that depends on one or more reactive signals.
- **keys**: A list of objects to watch. If any key changes, the computation will be re-created.
- **dependencies**: A list of dependency signals to monitor. If any dependency signal fires, the async computation will rerun.
- **lazy**: If true (default), execution is delayed until the signal is first read.
- **initialValue**: An optional initial value before the computation resolves.
- **debugLabel**: An optional debug label.

### Example

````dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class SearchResultsWidget extends HookWidget {
  const SearchResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final searchQuery = useSignal('');

    // Re-runs search query automatically whenever searchQuery.value changes
    final resultsSignal = useAsyncComputed(
      () async {
        if (searchQuery.value.isEmpty) return <SearchResult>[];
        return await performSearch(searchQuery.value);
      },
      options: AsyncSignalOptions(dependencies: [searchQuery]),
    );

    return Column(
      children: [
        TextField(
          onChanged: (val) => searchQuery.value = val,
          decoration: const InputDecoration(labelText: 'Search'),
        ),
        Expanded(
          child: resultsSignal.value.map(
            data: (results) => ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, idx) => ListTile(title: Text(results[idx].title)),
            ),
            error: (err, _) => Text('Error: $err'),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ),
      ],
    );
  }
}
````
