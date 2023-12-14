import 'package:flutter/material.dart';

import '../domain/repository/todos.dart';
import '../domain/usecase/add_todo.dart';
import '../domain/usecase/delete_completed_todos.dart';
import '../domain/usecase/delete_todo.dart';
import '../domain/usecase/get_todos.dart';
import '../domain/usecase/update_todo.dart';
import 'viewmodel/todo_list.dart';
import 'views/todo_list.dart';

class TodosApp extends StatelessWidget {
  const TodosApp({
    super.key,
    required this.todosRepository,
  });

  final TodosRepository todosRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TodoListView(
        viewModel: TodoListViewModel(
          getTodos: GetTodos(todosRepository),
          deleteTodo: DeleteTodo(todosRepository),
          deleteCompletedTodos: DeleteCompletedTodos(todosRepository),
          updateTodo: UpdateTodo(todosRepository),
          addTodo: AddTodo(todosRepository),
        ),
      ),
    );
  }
}
