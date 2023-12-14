import '../model/todo.dart';
import '../repository/todos.dart';

class UpdateTodo {
  final TodosRepository _todosRepository;

  UpdateTodo(this._todosRepository);

  Future<void> call(Todo todo) async {
    await _todosRepository.update(todo);
  }
}
