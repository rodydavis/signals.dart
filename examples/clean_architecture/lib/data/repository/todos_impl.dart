import 'package:clean_architecture/domain/model/todo.dart';

import '../../domain/repository/todos.dart';
import '../source/database/database.dart';

class TodosRepositoryImpl implements TodosRepository {
  final Database database;

  TodosRepositoryImpl(this.database) {
    database.addMigration(1, '''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        completed INTEGER
      );
    ''');
  }

  @override
  Future<int> add(Todo todo) async {
    final result = await database.execute(
      '''
      INSERT INTO todos (title, completed) VALUES (?, ?) RETURNING id;
      ''',
      params: [todo.title, todo.completed],
    );
    return result.last['id'] as int;
  }

  String get _selectSql => '''
    SELECT * FROM todos
    ORDER BY completed ASC, id DESC;
  ''';

  @override
  Future<List<Todo>> getAll() async {
    final todos = await database.get(_selectSql);
    return todos.map(Todo.fromJson).toList();
  }

  @override
  Future<void> remove(Todo todo) async {
    await database.execute(
      '''
      DELETE FROM todos WHERE id = ?;
      ''',
      params: [todo.id],
    );
  }

  @override
  Future<void> update(Todo todo) async {
    await database.execute(
      '''
      UPDATE todos SET title = ?, completed = ? WHERE id = ?;
      ''',
      params: [todo.title, todo.completed, todo.id],
    );
  }

  @override
  Future<Todo?> get(int id) async {
    final result = await database.getSingleOrNull(
      'SELECT * FROM todos WHERE id = ?;',
      params: [id],
    );
    if (result == null) {
      return null;
    } else {
      return Todo.fromJson(result);
    }
  }

  @override
  Future<void> removeCompleted() async {
    await database.execute(
      '''
      DELETE FROM todos WHERE completed = 1;
      ''',
    );
  }

  @override
  Stream<List<Todo>> watchAll() {
    return database.watch(
      _selectSql,
      triggerOnTables: ['todos'],
    ).map((todos) => todos.map(Todo.fromJson).toList());
  }
}
