import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:signals_mvi_example/core/view_model_mixin.dart';
import 'package:signals_mvi_example/posts/data/post_error.dart';
import 'package:signals_mvi_example/posts/data/post_model.dart';
import 'package:signals_mvi_example/posts/view_model/posts_view_model.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({
    required this.viewModel,
    super.key,
  });

  final PostsViewModel viewModel;

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen>
    with ViewModelMixin<PostsScreen, PostsViewModel> {
  @override
  PostsViewModel provideViewModel() => widget.viewModel..addEvent(FetchPosts());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => addEvent(FetchPosts()),
        child: Watch(
          debugLabel: 'Posts Content',
          (context) => AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: switch (viewModel.state.value) {
              PostsLoading() => const _LoadingIndicator(),
              PostsLoaded(posts: final posts) => _PostList(posts: posts),
              PostsError(error: final error) => _ErrorMessage(error: error),
            },
          ),
        ),
      ),
    );
  }
}

class _PostList extends StatelessWidget {
  const _PostList({required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final post = posts[index];

        return ListTile(
          title: Text(post.title),
          subtitle: Text(post.body),
        );
      },
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({required this.error});

  final PostError error;

  @override
  Widget build(BuildContext context) {
    final errorMessage = switch (error) {
      PostError.unknown => 'Unknown error',
      PostError.parse => 'Error parsing data',
    };

    return Center(
      child: Text(errorMessage),
    );
  }
}
