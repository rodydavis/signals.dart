class Post {
  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': final int userId,
        'id': final int id,
        'title': final String title,
        'body': final String body,
      } =>
        Post(
          userId: userId,
          id: id,
          title: title,
          body: body,
        ),
      _ => throw const FormatException('Failed to load post.'),
    };
  }

  final int userId;
  final int id;
  final String title;
  final String body;
}
