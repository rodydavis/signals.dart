import '../model/todo.dart';

abstract class TodosRepository {
  Future<List<Todo>> getAll();
  Stream<List<Todo>> watchAll();
  Future<Todo?> get(int id);
  Future<int> add(Todo todo);
  Future<void> remove(Todo todo);
  Future<void> update(Todo todo);
  Future<void> removeCompleted();
}
