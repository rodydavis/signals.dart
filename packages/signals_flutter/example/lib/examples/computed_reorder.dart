import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reorderable List with Signals')),
      body: const ReorderableItemList(),
    );
  }
}

class ReorderableItemList extends StatefulWidget {
  const ReorderableItemList({super.key});

  @override
  State<ReorderableItemList> createState() => _ReorderableItemListState();
}

class _ReorderableItemListState extends State<ReorderableItemList> {
  final allItems = listSignal<ItemModel>([
    ItemModel(id: '1', title: 'Item 1', orderIndex: 0, categoryId: 'A'),
    ItemModel(id: '2', title: 'Item 2', orderIndex: 1, categoryId: 'A'),
    ItemModel(id: '3', title: 'Item 3', orderIndex: 2, categoryId: 'B'),
    ItemModel(id: '4', title: 'Item 4', orderIndex: 3, categoryId: 'A'),
    ItemModel(id: '5', title: 'Item 5', orderIndex: 4, categoryId: 'B'),
    ItemModel(id: '6', title: 'Item 6', orderIndex: 5, categoryId: 'A'),
    ItemModel(id: '7', title: 'Item 7', orderIndex: 6, categoryId: 'A'),
    ItemModel(id: '8', title: 'Item 8', orderIndex: 7, categoryId: 'B'),
    ItemModel(id: '9', title: 'Item 9', orderIndex: 8, categoryId: 'A'),
    ItemModel(id: '10', title: 'Item 10', orderIndex: 9, categoryId: 'A'),
    ItemModel(id: '11', title: 'Item 11', orderIndex: 10, categoryId: 'A'),
    ItemModel(id: '12', title: 'Item 12', orderIndex: 11, categoryId: 'A'),
    ItemModel(id: '13', title: 'Item 13', orderIndex: 12, categoryId: 'A'),
    ItemModel(id: '14', title: 'Item 14', orderIndex: 13, categoryId: 'A'),
    ItemModel(id: '15', title: 'Item 15', orderIndex: 14, categoryId: 'A'),
    ItemModel(id: '16', title: 'Item 16', orderIndex: 15, categoryId: 'A'),
    ItemModel(id: '17', title: 'Item 17', orderIndex: 16, categoryId: 'A'),
    ItemModel(id: '18', title: 'Item 18', orderIndex: 17, categoryId: 'A'),
    ItemModel(id: '19', title: 'Item 19', orderIndex: 18, categoryId: 'A'),
    ItemModel(id: '20', title: 'Item 20', orderIndex: 19, categoryId: 'A'),
  ]);

  final selectedCategoryId = signal<String>('A');

  late final filteredAndSortedItems = computed(() {
    final filtered = allItems
        .where((item) => item.categoryId == selectedCategoryId.value)
        .toList();
    filtered.sort((a, b) {
      int orderComparison = a.orderIndex.compareTo(b.orderIndex);
      if (orderComparison != 0) return orderComparison;
      // Newer items first if order index is the same
      return b.createdAt.compareTo(a.createdAt);
    });
    return filtered;
  });

  void reorderItems(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final items = filteredAndSortedItems.value;
    final ItemModel item = items.removeAt(oldIndex);
    items.insert(newIndex, item);

    batch(() {
      // Update orderIndex for all items
      for (int i = 0; i < items.length; i++) {
        final updatedItem = items[i].copyWith(orderIndex: i);
        final allItemsIndex =
            allItems.indexWhere((element) => element.id == updatedItem.id);
        if (allItemsIndex != -1) {
          allItems[allItemsIndex] = updatedItem;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            selectedCategoryId.value =
                selectedCategoryId.value == 'A' ? 'B' : 'A';
          },
          child: const Text('Switch Category'),
        ),
        Expanded(
          child: Watch((context) {
            final items = filteredAndSortedItems.value;
            return ReorderableListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  key: ValueKey(item.id),
                  title: Text(item.title),
                  subtitle: Text(
                      'Order: ${item.orderIndex}, Category: ${item.categoryId}'),
                );
              },
              onReorder: reorderItems,
            );
          }),
        ),
      ],
    );
  }
}

class ItemModel {
  final String id;
  final String title;
  final int orderIndex;
  final String categoryId;
  final DateTime createdAt;

  ItemModel({
    required this.id,
    required this.title,
    required this.orderIndex,
    required this.categoryId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  ItemModel copyWith(
      {String? id, String? title, int? orderIndex, String? categoryId}) {
    return ItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      orderIndex: orderIndex ?? this.orderIndex,
      categoryId: categoryId ?? this.categoryId,
      createdAt: createdAt,
    );
  }
}
