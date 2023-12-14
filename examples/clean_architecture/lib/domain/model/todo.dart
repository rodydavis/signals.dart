class Todo {
  final int id;
  final String title;
  final int completed;

  bool get isCompleted => completed == 1;

  Todo({
    required this.id,
    required this.title,
    required this.completed,
  });

  factory Todo.newTodo({
    required String title,
    int completed = 0,
  }) {
    return Todo(
      id: -1,
      title: title,
      completed: completed,
    );
  }

  Todo copyWith({
    int? id,
    String? title,
    int? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  @override
  String toString() => 'Todo id: $id, title: $title, completed: $completed';

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'] as int,
        title: json['title'] as String,
        completed: json['completed'] as int,
      );

  Map<String, dynamic> toJson() => {
        if (id != -1) 'id': id,
        'title': title,
        'completed': completed,
      };
}
