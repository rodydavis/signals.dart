import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'data/repository/todos_impl.dart';
import 'data/source/database/database.dart';
import 'presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final db = Database('${dir.path}/todos.db');
  final todosRepository = TodosRepositoryImpl(db);
  await db.init();
  runApp(TodosApp(todosRepository: todosRepository));
}
