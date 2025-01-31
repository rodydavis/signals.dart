import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:multiple_result/multiple_result.dart';
import 'package:signals_mvi_example/posts/data/post_error.dart';
import 'package:signals_mvi_example/posts/data/post_model.dart';

final class PostsRepository {
  Future<Result<List<Post>, PostError>> fetchPosts() async {
    // Simulate a delay to show the loading state, sometimes the API is too fast
    await Future<void>.delayed(const Duration(seconds: 1));

    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode != 200) {
      return const Error(PostError.unknown);
    }

    try {
      final data = List<Map<String, dynamic>>.from(
        jsonDecode(response.body) as List,
      );

      return Success(data.map(Post.fromJson).toList());
    } catch (_) {
      return const Error(PostError.parse);
    }
  }
}
