import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:signals/signals_flutter.dart';

import '../../database/database.dart';
import 'state.dart';

class CategoriesDrawer extends StatefulWidget {
  const CategoriesDrawer({super.key});

  @override
  State<CategoriesDrawer> createState() => _CategoriesDrawerState();
}

class _CategoriesDrawerState extends State<CategoriesDrawer> {
  final stream = AppDatabase.instance().categoriesWithCount().toSignal();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.orange),
            child: Text(
              'Todo-List Demo with drift',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
          Flexible(
            child: Watch((context) {
              final value = stream.value.value;
              final categories = value ?? <CategoryWithCount>[];
              return ListView.builder(
                itemBuilder: (context, index) {
                  return _CategoryDrawerEntry(entry: categories[index]);
                },
                itemCount: categories.length,
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _CategoryDrawerEntry extends StatelessWidget {
  final CategoryWithCount entry;

  const _CategoryDrawerEntry({required this.entry});

  @override
  Widget build(BuildContext context) {
    final category = entry.category;
    final isActive = activeCategory.watch(context)?.id == category?.id;
    String title;
    if (category == null) {
      title = 'No category';
    } else {
      title = category.name;
    }

    final rowContent = [
      if (category != null)
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () async {
              final newColor = await _selectColor(context, category.color);
              if (newColor != null) {
                final update = AppDatabase.instance().categories.update()
                  ..whereSamePrimaryKey(category);
                await update.write(CategoriesCompanion(color: Value(newColor)));
              }
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: category.color,
              ),
              child: const SizedBox.square(dimension: 20),
            ),
          ),
        ),
      Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color:
              isActive ? Theme.of(context).colorScheme.secondary : Colors.black,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text('${entry.count} entries'),
      ),
    ];

    // also show a delete button if the category can be deleted
    if (category != null) {
      rowContent.addAll([
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.delete_outline),
          color: Colors.red,
          onPressed: () async {
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Delete'),
                  content: Text('Really delete category $title?'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                );
              },
            );

            // can be null when the dialog is dismissed
            if (confirmed == true) {
              AppDatabase.instance().deleteCategory(category);
            }
          },
        ),
      ]);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        color: isActive
            ? Colors.orangeAccent.withOpacity(0.3)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            activeCategory.value = category;
            Navigator.pop(context); // close the navigation drawer
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: rowContent,
            ),
          ),
        ),
      ),
    );
  }
}

Future<Color?> _selectColor(BuildContext context, Color initial) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: initial,
            onColorChanged: (color) => Navigator.pop(context, color),
          ),
        ),
      );
    },
  );
}
