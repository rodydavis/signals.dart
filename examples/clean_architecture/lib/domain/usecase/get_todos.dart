import '../../data/repository/todos_impl.dart';
import '../model/todo.dart';

class GetTodos {
  final TodosRepository _todosRepository;

  GetTodos(this._todosRepository);

  Stream<List<Todo>> call() {
    return _todosRepository.watchAll();
  }
}
