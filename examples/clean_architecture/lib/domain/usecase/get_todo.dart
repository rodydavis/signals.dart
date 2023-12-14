import '../../data/repository/todos_impl.dart';
import '../model/todo.dart';

class GetTodo {
  final TodosRepository _todosRepository;

  GetTodo(this._todosRepository);

  Future<Todo?> call(int id) async {
    return await _todosRepository.get(id);
  }
}
