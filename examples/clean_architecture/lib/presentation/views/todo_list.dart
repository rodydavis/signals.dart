import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../domain/model/todo.dart';
import '../viewmodel/todo_list.dart';
import 'edit_todo.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({super.key, required this.viewModel});

  final TodoListViewModel viewModel;

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  @override
  void initState() {
    widget.viewModel.init();
    super.initState();
  }

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: widget.viewModel.deleteCompletedTodos,
            tooltip: 'Delete completed todos',
          ),
        ],
      ),
      body: Watch((context) {
        if (widget.viewModel.todos.isEmpty) {
          return const Center(
            child: Text('No todos'),
          );
        }
        return ListView.builder(
          itemCount: widget.viewModel.todos.length,
          itemBuilder: (context, index) {
            final todo = widget.viewModel.todos[index];
            return ListTile(
              title: Text(todo.title),
              onTap: () async {
                final result =
                    await Navigator.of(context).push<Todo?>(MaterialPageRoute(
                  builder: (context) => EditTodo(todo: todo),
                  fullscreenDialog: true,
                ));
                if (result != null) {
                  widget.viewModel.editTodo(result);
                }
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => widget.viewModel.deleteTodo(todo),
                  ),
                  Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) =>
                        widget.viewModel.markTodoAsCompleted(todo, value!),
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result =
              await Navigator.of(context).push<Todo?>(MaterialPageRoute(
            builder: (context) => const EditTodo(),
            fullscreenDialog: true,
          ));
          if (result != null) {
            widget.viewModel.addTodo(result);
          }
        },
      ),
    );
  }
}
