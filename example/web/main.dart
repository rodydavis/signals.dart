import 'dart:html';

import 'package:dart_signals/dart_signals.dart';

typedef Task = ({String title, bool completed});

void main() {
  // Application logic
  final todoForm = document.getElementById("todoForm")!;
  final todoInput = document.getElementById("todoInput") as InputElement;
  final todoList = document.getElementById("todoList")!;
  final taskFilter = document.getElementById("taskFilter")!;
  final taskCounter = document.getElementById("taskCounter")!;

  final tasks = createSignal<List<Task>>([]);
  final filter = createSignal("all");

  final filteredTasks = createComputed(() {
    final currentFilter = filter.value;
    final currentTasks = tasks.value;
    if (currentFilter == "all") {
      return currentTasks;
    } else if (currentFilter == "active") {
      return currentTasks.where((task) => !task.completed).toList();
    } else {
      return currentTasks.where((task) => task.completed).toList();
    }
  });

  final taskCount = createComputed(() {
    return tasks.value.length;
  });

  final activeTaskCount = createComputed(() {
    return tasks.value.where((task) => !task.completed).length;
  });

  final completedTaskCount = createComputed(() {
    return tasks.value.where((task) => task.completed).length;
  });

  todoForm.addEventListener("submit", (event) {
    event.preventDefault();
    final taskTitle = todoInput.value?.trim();
    if (taskTitle != null) {
      final newTask = (title: taskTitle, completed: false);
      tasks.value = [...tasks.value, newTask];
      todoInput.value = "";
    }
  });

  taskFilter.addEventListener("change", (event) {
    final target = event.target as InputElement;
    filter.value = target.value ?? '';
  });

  createEffect(() {
    final currentTasks = filteredTasks.value;
    todoList.innerHtml = "";
    for (var index = 0; index < currentTasks.length; index++) {
      final task = currentTasks[index];
      final listItem = document.createElement("li");
      final label = document.createElement("label");
      final checkbox = document.createElement("input") as InputElement;
      checkbox.type = "checkbox";
      checkbox.checked = task.completed;
      checkbox.addEventListener("change", (e) {
        tasks.value[index] = (
          title: tasks.value[index].title,
          completed: checkbox.checked ?? false,
        );
        tasks.value = [...tasks.value];
      });
      label.append(checkbox);
      label.append(Text(" ${task.title}"));
      listItem.append(label);
      todoList.append(listItem);
    }
  });

  createEffect(() {
    taskCounter.text = '''
        Total: ${taskCount.value}, 
        Active: ${activeTaskCount.value}, 
        Completed: ${completedTaskCount.value}
        ''';
  });
}
