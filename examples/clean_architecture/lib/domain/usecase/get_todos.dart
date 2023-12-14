import '../model/todo.dart';
import '../repository/todos.dart';

class GetTodos {
  final TodosRepository _todosRepository;

  GetTodos(this._todosRepository);

  Stream<List<Todo>> call() {
    return _todosRepository.watchAll();
  }
}
