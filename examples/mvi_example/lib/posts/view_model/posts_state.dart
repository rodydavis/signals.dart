import 'package:signals_mvi_example/core/base_view_model.dart';
import 'package:signals_mvi_example/posts/data/post_error.dart';
import 'package:signals_mvi_example/posts/data/post_model.dart';

sealed class PostsState extends BaseState {
  const PostsState();
}

final class PostsLoading extends PostsState {
  const PostsLoading();
}

final class PostsLoaded extends PostsState {
  const PostsLoaded(this.posts);

  final List<Post> posts;
}

final class PostsError extends PostsState {
  const PostsError(this.error);

  final PostError error;
}
