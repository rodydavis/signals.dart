import 'dart:js_interop';
import 'package:web/helpers.dart';
import 'package:signals/signals.dart';

void main() {
  final todoForm = document.getElementById("todoForm")!;
  final todoInput = document.getElementById("todoInput") as HTMLInputElement;
  final todoList = document.getElementById("todoList")!;
  final taskFilter = document.getElementById("taskFilter")!;

  final app = TasksApp();

  todoForm.addEventListener(
    "submit",
    (Event event) {
      event.preventDefault();
      final title = todoInput.value.trim();
      if (title.isEmpty) return;
      final task = TaskElement.create((title: title, completed: false));
      app.tasks.add(task);
      todoInput.value = "";
    }.toJS,
  );

  taskFilter.addEventListener(
    "change",
    (Event event) {
      final target = event.target as HTMLInputElement;
      app.filter.value = target.value;
    }.toJS,
  );

  effect(() {
    todoList.innerHTML = '';
    for (var i = 0; i < app.filteredTasks.value.length; i++) {
      final task = app.filteredTasks.value[i];
      todoList.appendChild(task.root);
    }
  });

  effect(() {
    final el = document.getElementById("tasks-total")!;
    el.innerHTML = app.taskCount.value.toString();
  });

  effect(() {
    final el = document.getElementById("tasks-active")!;
    el.innerHTML = app.activeTaskCount.value.toString();
  });

  effect(() {
    final el = document.getElementById("tasks-completed")!;
    el.innerHTML = app.completedTaskCount.value.toString();
  });
}

typedef Task = ({bool completed, String title});

class TasksApp {
  final tasks = listSignal<TaskElement>([]);
  final filter = signal("all");

  late final filteredTasks = computed(() {
    final currentFilter = filter.value;
    final currentTasks = tasks.value;
    if (currentFilter == "all") {
      return currentTasks.toList();
    } else if (currentFilter == "active") {
      return currentTasks.where((task) => !task.state.value.completed).toList();
    } else {
      return currentTasks.where((task) => task.state.value.completed).toList();
    }
  });

  late final taskCount = computed(() {
    return tasks.length;
  });

  late final activeTaskCount = computed(() {
    return tasks.where((task) => !task.state.value.completed).length;
  });

  late final completedTaskCount = computed(() {
    // we use taskCount.peek() instead of taskCount.value
    // because this will recompute when activeTaskCount changes
    // thus, we can avoid an unnecessary subscription
    return taskCount.peek() - activeTaskCount.value;
  });
}

class TaskElement {
  final Element root;
  final Function cleanup;
  final Signal<Task> state;

  TaskElement(this.state, this.root, this.cleanup);

  static TaskElement create(Task task) {
    final listItem = document.createElement("li");
    final label = document.createElement("label");
    final checkbox = document.createElement("input") as HTMLInputElement;
    checkbox.type = "checkbox";
    checkbox.checked = task.completed;
    final state = signal(task);
    final cleanup = effect(() {
      final change = (Event e) {
        state.value = (
          title: state.value.title,
          completed: checkbox.checked,
        );
      }.toJS;
      checkbox.addEventListener("change", change);
      return () {
        checkbox.removeEventListener("change", change);
      };
    });
    label.appendChild(checkbox);
    label.append(" ${task.title}".toJS);
    listItem.appendChild(label);
    return TaskElement(state, listItem, cleanup);
  }

  void remove() {
    cleanup();
    root.remove();
  }
}
