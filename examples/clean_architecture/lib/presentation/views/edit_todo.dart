import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../domain/model/todo.dart';

class EditTodo extends StatefulWidget {
  const EditTodo({super.key, this.todo});

  final Todo? todo;

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  final _formKey = GlobalKey<FormState>();
  late final title = TextEditingController(text: widget.todo?.title);
  late final completed = signal(widget.todo?.isCompleted ?? false);
  bool get isNew => widget.todo == null;

  Future<void> save(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final todo = Todo(
        id: widget.todo?.id ?? -1,
        title: title.text,
        completed: completed.value ? 1 : 0,
      );
      Navigator.of(context).pop(todo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${isNew ? 'Add' : 'Edit'} Todo'),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () => save(context),
            ),
          ],
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ListTile(
                    title: TextFormField(
                      controller: title,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Watch(
                    (context) => CheckboxListTile(
                      title: const Text('Completed'),
                      value: completed.value,
                      onChanged: (val) => completed.value = val!,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
