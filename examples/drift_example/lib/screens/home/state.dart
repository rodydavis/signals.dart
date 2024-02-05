import 'package:signals/signals.dart';

import '../../database/database.dart';

final activeCategory = signal<Category?>(null);

final entriesInCategory = streamSignal(() {
  final database = AppDatabase.instance();
  final current = activeCategory()?.id;
  return database.entriesInCategory(current);
});
