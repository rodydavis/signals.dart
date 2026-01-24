import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

sealed class AppAction {}

class AddItemAction extends AppAction {
  String item;
  AddItemAction(this.item);
}

class UpdateItemAction extends AppAction {
  int index;
  String item;
  UpdateItemAction(this.index, this.item);
}

class RemoveItemAction extends AppAction {
  int index;
  RemoveItemAction(this.index);
}

class PerformSearchAction extends AppAction {
  String query;
  PerformSearchAction(this.query);
}

@immutable
class AppState {
  final List<String> items;
  final String searchQuery;

  const AppState(this.items, this.searchQuery);
}

AppState reducer(AppState state, AppAction action) {
  return switch (action) {
    AddItemAction action => AppState(
        List.from(state.items)..add(action.item),
        state.searchQuery,
      ),
    RemoveItemAction action => AppState(
        List.from(state.items)..removeAt(action.index),
        state.searchQuery,
      ),
    UpdateItemAction action => AppState(
        List.from(state.items)..[action.index] = action.item,
        state.searchQuery,
      ),
    PerformSearchAction action => AppState(state.items, action.query),
  };
}

class Store<T extends AppState, A extends AppAction> extends FlutterSignal<T> {
  Store(this.reducer, super.internalValue);
  final T Function(T state, A action) reducer;

  void dispatch(A action) {
    value = reducer(value, action);
  }

  T get state => value;
}

class AppStore extends Store<AppState, AppAction> {
  AppStore() : super(reducer, const AppState([], ""));

  late final items = select((v) => v.value.items);
  late final searchQuery = select((v) => v.value.searchQuery);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const Example(),
    );
  }
}

class Example extends StatelessWidget {
  const Example({
    super.key,
    this.title = 'Example',
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SignalProvider<AppStore>(
      create: () => AppStore(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: Builder(
          builder: (context) {
            final store = SignalProvider.of<AppStore>(context)!;
            if (store.items.value.isEmpty) {
              return const Center(child: Text('No items added'));
            }
            return ListView.builder(
              itemCount: store.items.value.length,
              itemBuilder: (context, index) {
                final item = store.items.value[index];
                return ListTile(
                  key: ValueKey((store.items.value.length, index)),
                  title: TextFormField(
                    initialValue: item,
                    onChanged: (val) =>
                        store.dispatch(UpdateItemAction(index, val)),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => store.dispatch(RemoveItemAction(index)),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: Builder(builder: (context) {
          final store = SignalProvider.of<AppStore>(context, listen: false)!;
          return FloatingActionButton(
            onPressed: () => store.dispatch(AddItemAction('New Item')),
            tooltip: 'Add Item',
            child: const Icon(Icons.add),
          );
        }),
      ),
    );
  }
}
