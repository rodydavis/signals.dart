import 'package:signals/signals.dart';

import '../../domain/model/todo.dart';
import '../../domain/usecase/add_todo.dart';
import '../../domain/usecase/delete_completed_todos.dart';
import '../../domain/usecase/delete_todo.dart';
import '../../domain/usecase/get_todos.dart';
import '../../domain/usecase/update_todo.dart';

class TodoListViewModel {
  final GetTodos _getTodos;
  final AddTodo _addTodo;
  final UpdateTodo _updateTodo;
  final DeleteTodo _deleteTodo;
  final DeleteCompletedTodos _deleteCompletedTodos;
  late final _connectTodos = connect<List<Todo>>(todos);
  final todos = listSignal<Todo>([]);

  TodoListViewModel({
    required GetTodos getTodos,
    required DeleteTodo deleteTodo,
    required DeleteCompletedTodos deleteCompletedTodos,
    required UpdateTodo updateTodo,
    required AddTodo addTodo,
  })  : _getTodos = getTodos,
        _deleteTodo = deleteTodo,
        _updateTodo = updateTodo,
        _addTodo = addTodo,
        _deleteCompletedTodos = deleteCompletedTodos;

  void init() {
    _connectTodos << _getTodos();
  }

  void deleteTodo(Todo todo) {
    _deleteTodo(todo.id);
  }

  void addTodo(Todo todo) {
    _addTodo(title: todo.title, completed: todo.isCompleted);
  }

  void editTodo(Todo todo) {
    _updateTodo(todo);
  }

  void markTodoAsCompleted(Todo todo, bool completed) {
    _updateTodo(todo.copyWith(completed: completed ? 1 : 0));
  }

  void deleteCompletedTodos() {
    _deleteCompletedTodos();
  }

  void dispose() {
    _connectTodos.dispose();
  }
}
