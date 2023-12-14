import '../repository/todos.dart';

class DeleteTodo {
  final TodosRepository _todosRepository;

  DeleteTodo(this._todosRepository);

  Future<void> call(int id) async {
    final current = await _todosRepository.get(id);
    if (current == null) {
      throw Exception('Todo not found');
    }
    await _todosRepository.remove(current);
  }
}
