import 'package:diffutil_dart/diffutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signals/signals_flutter.dart';

import 'edit_post_page.dart';
import 'interactive_posts_view_model.dart';
import 'widgets.dart';

class InteractivePostsTabView extends StatefulWidget {
  const InteractivePostsTabView({super.key});

  @override
  State<InteractivePostsTabView> createState() =>
      _InteractivePostsTabViewState();
}

class _InteractivePostsTabViewState extends State<InteractivePostsTabView> {
  late final InteractivePostsViewModel _viewModel;
  late final VoidCallback _interactivePostsDiffCleanUp;
  final Map<int, VoidCallback> _postCleanUps = {};

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<InteractivePostsViewModel>();
    _interactivePostsDiffCleanUp = _viewModel.interactivePostsDiff.subscribe(
      _onDiffEmitted,
    );
  }

  @override
  void dispose() {
    _interactivePostsDiffCleanUp();
    for (final unsubscribe in _postCleanUps.values) {
      unsubscribe();
    }
    super.dispose();
  }

  void _onDiffEmitted(AsyncState<InteractivePostsDiff> state) {
    if (!mounted) return;
    final diff = state.value;
    if (diff == null) return;

    for (final interactivePost in diff.added) {
      final postId = interactivePost.post.id;

      _postCleanUps[postId] = interactivePost
          .editPostViewModel
          .deletePostMutation
          .subscribe((value) {
            if (!mounted) return;
            switch (value) {
              case MutationSuccess():
                showSuccessSnackBar(
                  context: context,
                  message: 'Post $postId deleted successfully',
                );
              case MutationError(:final error):
                showErrorSnackBar(
                  context: context,
                  message: 'Error deleting post $postId',
                  error: error,
                );
              case _:
                break;
            }
          });
    }

    for (final interactivePost in diff.removed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _postCleanUps.remove(interactivePost.post.id)?.call();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostsListDeletingCountBannerWidget(),
        Expanded(
          child: Watch((context) {
            return _viewModel.interactivePostsDiff.value.map(
              data: (postDiffs) => _AnimatedPostsList(posts: postDiffs.current),
              error: (error, _) => PostsListErrorWidget(
                error: error,
                onRetry: _viewModel.interactivePostsDiff.reload,
              ),
              loading: () => const PostsListLoadingWidget(),
            );
          }),
        ),
      ],
    );
  }
}

class _AnimatedPostsList extends StatefulWidget {
  const _AnimatedPostsList({required this.posts});

  final List<InteractivePost> posts;

  @override
  State<_AnimatedPostsList> createState() => _AnimatedPostsListState();
}

class _AnimatedPostsListState extends State<_AnimatedPostsList> {
  final _listKey = GlobalKey<AnimatedListState>();
  late List<InteractivePost> _items;

  static const _animationDuration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _items = widget.posts.toList();
  }

  @override
  void didUpdateWidget(_AnimatedPostsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.posts, widget.posts)) {
      _applyUpdates(oldWidget.posts);
    }
  }

  void _applyUpdates(List<InteractivePost> previous) {
    final diffResult = calculateListDiff<InteractivePost>(
      previous,
      widget.posts,
      detectMoves: false,
      equalityChecker: (a, b) => a.post == b.post,
    );

    var hasContentChanges = false;

    for (final update in diffResult.getUpdates()) {
      update.when(
        insert: (pos, count) {
          for (var i = 0; i < count; i++) {
            final index = pos + i;
            _items.insert(index, widget.posts[index]);
            _listKey.currentState?.insertItem(
              index,
              duration: _animationDuration,
            );
          }
        },
        remove: (pos, count) {
          for (var i = count - 1; i >= 0; i--) {
            final index = pos + i;
            final item = _items.removeAt(index);
            _listKey.currentState?.removeItem(
              index,
              (context, animation) => _buildItem(context, item, animation),
              duration: _animationDuration,
            );
          }
        },
        change: (pos, _) {
          _items[pos] = widget.posts[pos];
          hasContentChanges = true;
        },
        move: (from, to) {
          final item = _items.removeAt(from);
          _listKey.currentState?.removeItem(
            from,
            (context, animation) => _buildItem(context, item, animation),
            duration: _animationDuration,
          );
          _items.insert(to, item);
          _listKey.currentState?.insertItem(to, duration: _animationDuration);
        },
      );
    }

    if (hasContentChanges) {
      setState(() {});
    }
  }

  Widget _buildItem(
    BuildContext context,
    InteractivePost post,
    Animation<double> animation,
  ) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: PostCard(key: ValueKey(post.post.id), interactivePost: post),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) return PostsListDataEmptyWidget();

    return AnimatedList(
      key: _listKey,
      initialItemCount: _items.length,
      itemBuilder: (context, index, animation) {
        return _buildItem(context, _items[index], animation);
      },
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.interactivePost});

  final InteractivePost interactivePost;

  @override
  Widget build(BuildContext context) {
    final editPostViewModel = interactivePost.editPostViewModel;

    return PostListCardWidget(
      post: interactivePost.post,
      actions: [
        Flexible(
          child: Watch((context) {
            return LoadingFilledButton(
              isLoading: editPostViewModel.updatePostMutation.value.isPending,
              isEnabled: editPostViewModel.updatePostMutation.canRun.value,
              label: 'Edit',
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => EditPostPage(post: interactivePost.post),
                ),
              ),
            );
          }),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: Watch((context) {
            return LoadingFilledButton(
              isLoading: editPostViewModel.deletePostMutation.value.isPending,
              isEnabled: editPostViewModel.deletePostMutation.canRun.value,
              label: 'Delete',
              onPressed: () =>
                  editPostViewModel.deletePost(id: interactivePost.post.id),
            );
          }),
        ),
      ],
    );
  }
}

class PostsListDeletingCountBannerWidget extends StatelessWidget {
  const PostsListDeletingCountBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<InteractivePostsViewModel>();
    return Watch((context) {
      final theme = Theme.of(context);
      final count = viewModel.deletingCount.value;

      return ClipRect(
        child: AnimatedAlign(
          duration: const .new(milliseconds: 300),
          alignment: .topCenter,
          heightFactor: count == 0 ? 0.0 : 1.0,
          child: Container(
            color: theme.colorScheme.primary,
            width: .infinity,
            padding: const .all(16.0),
            child: Text(
              'Deleting $count post${count > 1 ? 's' : ''}.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      );
    });
  }
}
