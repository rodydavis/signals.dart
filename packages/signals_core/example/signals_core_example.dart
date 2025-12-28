import 'dart:js_interop';
import 'package:signals_core/signals_core.dart';
import 'package:web/web.dart';

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
    final currentTasks = tasks;
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
      event.preventDefault();
      final taskTitle = todoInput.value.trim();
      if (taskTitle.isNotEmpty) {
        final newTask = (title: taskTitle, completed: false);
        tasks.add(newTask);
        todoInput.value = "";
      }
    }.toJS,
  );

  taskFilter.addEventListener(
    "change",
    (Event event) {
      final target = event.target as HTMLInputElement;
      filter.value = target.value;
    }.toJS,
  );

  effect(() {
    final currentTasks = filteredTasks.value;
    todoList.innerHTML = "".toJS;
    for (var index = 0; index < currentTasks.length; index++) {
      final task = currentTasks[index];
      final listItem = document.createElement("li");
      final label = document.createElement("label");
      final checkbox = document.createElement("input") as HTMLInputElement;
      checkbox.type = "checkbox";
      checkbox.checked = task.completed;
      checkbox.addEventListener(
        "change",
        (Event e) {
          tasks[index] = (
            title: tasks[index].title,
            completed: checkbox.checked,
          );
        }.toJS,
      );
      label.append(checkbox);
      label.append(Text(" ${task.title}"));
      listItem.append(label);
      todoList.append(listItem);
    }
  });

  effect(() {
    taskCounter.textContent = '''
    Total: ${taskCount.value}, 
    Active: ${activeTaskCount.value}, 
    Completed: ${completedTaskCount.value}
    ''';
  });
}
