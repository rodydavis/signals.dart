import '../repository/todos.dart';

class DeleteCompletedTodos {
  final TodosRepository _todosRepository;

  DeleteCompletedTodos(this._todosRepository);

  Future<void> call() async {
    await _todosRepository.removeCompleted();
  }
}
