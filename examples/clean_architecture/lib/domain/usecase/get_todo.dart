import '../model/todo.dart';
import '../repository/todos.dart';

class GetTodo {
  final TodosRepository _todosRepository;

  GetTodo(this._todosRepository);

  Future<Todo?> call(int id) async {
    return await _todosRepository.get(id);
  }
}
