import 'package:flutter/material.dart';
import 'widgets.dart';
import 'package:provider/provider.dart';
import 'package:signals/signals_flutter.dart';

import 'edit_post_page.dart';
import 'posts_repository.dart';
import 'posts_view_model.dart';

class PostsTabView extends StatelessWidget {
  const PostsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<PostsViewModel>();

    return Watch((context) {
      return viewModel.postsStream.value.map(
        data: (posts) =>
            PostsListDataContent(posts: posts, viewModel: viewModel),
        error: (error, _) => PostsListErrorWidget(
          error: error,
          onRetry: viewModel.postsStream.reload,
        ),
        loading: () => const PostsListLoadingWidget(),
      );
    });
  }
}

class PostsListDataContent extends StatelessWidget {
  const PostsListDataContent({
    super.key,
    required this.posts,
    required this.viewModel,
  });

  final List<Post> posts;
  final PostsViewModel viewModel;

  void _navigateToEdit(BuildContext context, Post post) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => EditPostPage(post: post)));
  }

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return PostsListDataEmptyWidget();
    }

    return Padding(
      padding: const .all(16.0),
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostCard(
            key: ValueKey(post.id),
            post: post,
            onEditPressed: () => _navigateToEdit(context, post),
          );
        },
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post, required this.onEditPressed});

  final Post post;
  final VoidCallback onEditPressed;

  @override
  Widget build(BuildContext context) {
    return PostListCardWidget(
      post: post,
      actions: [LoadingFilledButton(onPressed: onEditPressed, label: 'Edit')],
    );
  }
}
