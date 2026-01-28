import 'package:signals/signals.dart';
import 'posts_repository.dart';

class EditPostViewModel {
  EditPostViewModel({required PostsRepository postsRepository})
    : _postsRepository = postsRepository;

  final PostsRepository _postsRepository;

  final isPostDeleted = signal<bool>(false);

  late final Computed hasPendingMutations = computed<bool>(
    () =>
        updatePostMutation.value.isPending ||
        deletePostMutation.value.isPending,
  );

  /// Create a [MutationSignal] where the initial value is [MutationIdle].
  late final deletePostMutation = MutationSignal<void>(
    canRun: (value) {
      // Optional callback to determine if the mutation can run.
      //
      // The [value] parameter is the current [MutationState] of the mutation.
      //
      // The [MutationSignal.canRun] signal automatically updates whenever:
      // - The mutation value changes (e.g., from idle to pending).
      // - Any signals read inside this callback change.
      //
      // Note: When the mutation is [MutationPending], [MutationSignal.run]
      // is ignored automatically, preventing multiple simultaneous executions.

      return !hasPendingMutations.value && !isPostDeleted.value;
    },
  );

  late final updatePostMutation = MutationSignal<Post>(
    canRun: (value) => !hasPendingMutations.value && !isPostDeleted.value,
  );

  Future<void> deletePost({required int id}) {
    // Use [MutationSignal.run] to automatically handle the mutation state
    // based on the async function provided.
    return deletePostMutation.run(
      () => _postsRepository.deletePost(id: id),
      onPending: () {
        // Optional callback when the function can be executed
        // and the state is [MutationPending].
        // This is called before the async function is executed.
      },
      onSuccess: (value) {
        // Optional callback when the function completes successfully
        // and the state is [MutationSuccess].

        isPostDeleted.value = true;
      },
      onError: (error, stackTrace) {
        // Optional callback when the function throws an error
        // and the state is [MutationError].
      },
      onSettled: (settled) {
        // Optional callback when the mutation is settled,
        // either successfully or with an error.
      },
    );
  }

  Future<void> updatePost({required Post post}) async {
    // Update the [MutationSignal] state manually.

    if (!updatePostMutation.canRun.value) return;
    updatePostMutation.setPending();
    try {
      final updatedPost = await _postsRepository.updatePost(post: post);
      updatePostMutation.setSuccess(updatedPost);
    } catch (error, stackTrace) {
      updatePostMutation.setError(error, stackTrace);
    }
  }

  void dispose() {
    isPostDeleted.dispose();
    hasPendingMutations.dispose();
    deletePostMutation.dispose();
    updatePostMutation.dispose();
  }
}
