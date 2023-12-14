import '../model/todo.dart';
import '../repository/todos.dart';

class AddTodo {
  final TodosRepository _todosRepository;

  AddTodo(this._todosRepository);

  Future<Todo> call({
    required String title,
    bool completed = false,
  }) async {
    final id = await _todosRepository.add(
      Todo.newTodo(
        title: title,
        completed: completed ? 1 : 0,
      ),
    );
    final result = await _todosRepository.get(id);
    if (result == null) {
      throw Exception('Todo not found');
    }
    return result;
  }
}
