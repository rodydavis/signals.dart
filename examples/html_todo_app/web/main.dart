import 'dart:js_interop';
import 'package:web/helpers.dart';
import 'package:signals/signals.dart';

typedef Task = ({String title, bool completed});

void main() {
  final todoForm = document.getElementById("todoForm")!;
  final todoInput = document.getElementById("todoInput") as HTMLInputElement;
  final todoList = document.getElementById("todoList")!;
  final taskFilter = document.getElementById("taskFilter")!;
  final taskCounter = document.getElementById("taskCounter")!;

  final tasks = <Task>[].toSignal();
  final filter = signal("all");

  final filteredTasks = computed(() {
    final currentFilter = filter.value;
    final currentTasks = tasks.value;
    if (currentFilter == "all") {
      return currentTasks.toList();
    } else if (currentFilter == "active") {
      return currentTasks.where((task) => !task.completed).toList();
    } else {
      return currentTasks.where((task) => task.completed).toList();
    }
  });

  final taskCount = computed(() {
    return tasks.length;
  });

  final activeTaskCount = computed(() {
    return tasks.where((task) => !task.completed).length;
  });

  final completedTaskCount = computed(() {
    // we use taskCount.peek() instead of taskCount.value
    // because this will recompute when activeTaskCount changes
    // thus, we can avoid an unnecessary subscription
    return taskCount.peek() - activeTaskCount.value;
  });

  todoForm.addEventListener(
      "submit",
      (Event event) {
        print('trigger!');
        event.preventDefault();
        final taskTitle = todoInput.value.trim();
        final newTask = (title: taskTitle, completed: false);
        tasks.add(newTask);
        todoInput.value = "";
      }.toJS);

  taskFilter.addEventListener(
      "change",
      (Event event) {
        final target = event.target as HTMLInputElement;
        filter.value = target.value;
      }.toJS);

  effect(() {
    final currentTasks = filteredTasks.value;
    todoList.innerHTML = "";

    final cleanup = <Function>[];

    for (var i = 0; i < currentTasks.length; i++) {
      final task = currentTasks[i];
      final listItem = document.createElement("li");
      final label = document.createElement("label");
      final checkbox = document.createElement("input") as HTMLInputElement;
      checkbox.type = "checkbox";
      checkbox.checked = task.completed;
      cleanup.add(effect(() {
        final change = (Event e) {
          tasks[i] = (
            title: tasks[i].title,
            completed: checkbox.checked,
          );
        }.toJS;
        checkbox.addEventListener("change", change);
        return () {
          checkbox.removeEventListener("change", change);
        };
      }));
      label.appendChild(checkbox);
      label.append(" ${task.title}".toJS);
      listItem.appendChild(label);
      todoList.appendChild(listItem);
    }

    return () {
      for (final cb in cleanup) {
        cb();
      }
    };
  });

  effect(() {
    taskCounter.text = '''
    Total: ${taskCount.value}, 
    Active: ${activeTaskCount.value}, 
    Completed: ${completedTaskCount.value}
    ''';
  });
}
