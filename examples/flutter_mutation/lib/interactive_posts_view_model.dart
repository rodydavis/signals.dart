import 'dart:async';

import 'package:signals/signals.dart';
import 'edit_post_view_model.dart';
import '../posts_repository.dart';

/// Manages a stream of posts and their associated edit view models.
///
/// Transforms [Post] stream into [InteractivePostsDiff] emissions containing:
/// - Current list of [InteractivePost] for display
/// - Newly added posts for mutation listener setup
/// - Removed posts for cleanup
///
/// Provides [deletingCount] to track pending delete mutations across all posts.
///
/// Handles lifecycle management of [EditPostViewModel] instances, creating them
/// as posts are added and disposing them when posts are removed.
class InteractivePostsViewModel {
  InteractivePostsViewModel({
    required PostsRepository postsRepository,
    Duration disposeDelay = const .new(seconds: 1),
  }) : _postsRepository = postsRepository,
       _disposeEditPostViewModelDelay = disposeDelay;

  final PostsRepository _postsRepository;
  final Duration _disposeEditPostViewModelDelay;

  final Signal<Map<int, EditPostViewModel>> _editPostViewModels = signal({});

  late final interactivePostsDiff = streamSignal(
    () => _postsRepository.postsStream().map(_mapToInteractivePostsDiff),
  );

  late final deletingCount = computed(
    () => _editPostViewModels.value.values
        .where((viewModel) => viewModel.deletePostMutation.value.isPending)
        .length,
  );

  InteractivePostsDiff _mapToInteractivePostsDiff(List<Post> posts) {
    final previousViewModels = _editPostViewModels.value;
    final previousCurrent = interactivePostsDiff.value.value?.current ?? [];

    final newViewModels = <int, EditPostViewModel>{};
    final current = <InteractivePost>[];
    final added = <InteractivePost>[];
    final removed = <InteractivePost>[];

    for (final post in posts) {
      final isNew = !previousViewModels.containsKey(post.id);
      final viewModel =
          previousViewModels[post.id] ??
          EditPostViewModel(postsRepository: _postsRepository);
      newViewModels[post.id] = viewModel;

      final interactivePost = InteractivePost(
        post: post,
        editPostViewModel: viewModel,
      );
      current.add(interactivePost);
      if (isNew) added.add(interactivePost);
    }

    for (final interactivePost in previousCurrent) {
      if (newViewModels.containsKey(interactivePost.post.id)) continue;
      removed.add(interactivePost);
      disposeEditPostViewModel(interactivePost.editPostViewModel);
    }

    _editPostViewModels.value = newViewModels;

    return InteractivePostsDiff(
      current: current,
      added: added,
      removed: removed,
    );
  }

  void disposeEditPostViewModel(EditPostViewModel? viewModel) {
    if (viewModel == null) return;
    // We dispose later because the diff may remove some posts, and we want
    // listeners to be alive and notified of the latest state before cleanup
    // occurs. e.g. When an item is deleted, the diff stream can be updated
    // before the deletePostMutation is updated.
    _scheduleLater(
      () => viewModel.dispose(),
      duration: _disposeEditPostViewModelDelay,
    );
  }

  void dispose() {
    if (_editPostViewModels.disposed) return;
    interactivePostsDiff.dispose();
    deletingCount.dispose();
    for (var viewModel in _editPostViewModels.value.values) {
      viewModel.dispose();
    }
    _editPostViewModels.dispose();
  }
}

/// Represents a snapshot of posts with change tracking for subscriptions.
class InteractivePostsDiff {
  const InteractivePostsDiff({
    required this.current,
    required this.added,
    required this.removed,
  });

  final List<InteractivePost> current;

  final List<InteractivePost> added;

  final List<InteractivePost> removed;
}

/// A [Post] paired with its [EditPostViewModel] for interactive operations.
class InteractivePost {
  const InteractivePost({required this.post, required this.editPostViewModel});

  final Post post;
  final EditPostViewModel editPostViewModel;
}

void _scheduleLater(void Function() fn, {required Duration duration}) =>
    unawaited(Future<void>.delayed(duration).then((_) => fn()));
