import 'dart:convert';
import 'dart:js_interop';

import 'package:signals/signals.dart';
import 'package:web/web.dart';

void main() {
  final todoForm = document.getElementById("todoForm") as HTMLFormElement;
  final todoInput = document.getElementById("todoInput") as HTMLInputElement;
  final todoList = document.getElementById("todoList") as HTMLTableElement;
  final taskFilter = document.getElementById("taskFilter") as HTMLInputElement;

  final app = TasksApp();

  todoForm.onsubmit = (Event event) {
    event.preventDefault();
    final title = todoInput.value.trim();
    if (title.isEmpty) return;
    final task = TaskElement.create(app, (title: title, completed: false));
    app.tasks.add(task);
    app.save();
    todoInput.value = "";
  }.toJS;

  taskFilter.onchange = (Event event) {
    final target = event.target as HTMLInputElement;
    app.filter.value = target.value;
  }.toJS;

  effect(() {
    todoList.innerHTML = ''.toJS;
    final tasks = app.filteredTasks.value;
    for (var i = 0; i < tasks.length; i++) {
      final task = tasks[i];
      todoList.appendChild(task.root);
    }
  });

  effect(() {
    final el = document.getElementById("tasks-total")!;
    el.innerHTML = app.taskCount.value.toString().toJS;
  });

  effect(() {
    final el = document.getElementById("tasks-active")!;
    el.innerHTML = app.activeTaskCount.value.toString().toJS;
  });

  effect(() {
    final el = document.getElementById("tasks-completed")!;
    el.innerHTML = app.completedTaskCount.value.toString().toJS;
  });

  app.load();
}

typedef Task = ({bool completed, String title});

extension on Task {
  Map<String, Object> toJson() {
    return {
      'title': title,
      'completed': completed,
    };
  }
}

class TasksApp {
  final tasks = listSignal<TaskElement>([]);
  final filter = signal("all");

  late final filteredTasks = computed(() {
    final tasks = this.tasks.value;
    return switch (filter.value) {
      'all' => tasks.toList(),
      'active' => tasks.where((task) => !task.state.value.completed).toList(),
      (_) => tasks.where((task) => task.state.value.completed).toList(),
    };
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

  void save() {
    window.localStorage.setItem(
      'tasks',
      jsonEncode(tasks.map((e) => e.state.value.toJson()).toList()),
    );
  }

  void load() {
    final saved = window.localStorage.getItem('tasks');
    if (saved != null && saved.isNotEmpty) {
      final items = (jsonDecode(saved) as List).cast<Map>();
      batch(() {
        for (final item in items) {
          final task = TaskElement.create(this, (
            completed: item['completed'] as bool,
            title: item['title'] as String,
          ));
          tasks.add(task);
        }
      });
    }
  }
}

class TaskElement {
  final Element root;
  final List<Function> cleanup;
  final Signal<Task> state;
  final TasksApp app;

  TaskElement(this.app, this.state, this.root, this.cleanup);

  static TaskElement create(TasksApp app, Task task) {
    final base = document.createElement("tr");
    final state = signal(task);
    final cleanup = <Function>[];
    final instance = TaskElement(app, state, base, cleanup);
    base.appendChild(() {
      final select = state.select((e) => e.value.title);
      final el = document.createElement("td");
      final ctl = document.createElement("input") as HTMLInputElement;
      ctl.type = 'text';
      ctl.value = select.value;
      cleanup.add(effect(() {
        final change = (Event e) {
          state.value = (
            title: ctl.value,
            completed: state.value.completed,
          );
          app.save();
        }.toJS;
        ctl.addEventListener("change", change);
        return () {
          ctl.removeEventListener("change", change);
        };
      }));
      el.appendChild(ctl);
      return el;
    }());
    base.appendChild(() {
      final select = state.select((e) => e.value.completed);
      final el = document.createElement("td");
      final ctl = document.createElement("input") as HTMLInputElement;
      ctl.type = 'checkbox';
      ctl.checked = select.value;
      cleanup.add(effect(() {
        final change = (Event e) {
          state.value = (
            title: state.value.title,
            completed: ctl.checked,
          );
          app.save();
        }.toJS;
        ctl.addEventListener("change", change);
        return () {
          ctl.removeEventListener("change", change);
        };
      }));
      el.appendChild(ctl);
      return el;
    }());
    base.appendChild(() {
      final el = document.createElement("td");
      final btn = document.createElement("button") as HTMLButtonElement;
      btn.innerHTML = 'delete'.toJS;
      btn.onclick = (Event e) {
        instance.delete();
      }.toJS;
      el.appendChild(btn);
      return el;
    }());
    return instance;
  }

  void delete() {
    for (final cb in cleanup) {
      cb();
    }
    root.remove();
    app.tasks.removeWhere((e) => e.root == root);
    app.save();
  }
}
