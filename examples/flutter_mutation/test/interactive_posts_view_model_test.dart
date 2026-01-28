import 'dart:async';

import 'package:flutter_mutation/interactive_posts_view_model.dart';
import 'package:flutter_mutation/posts_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';
import 'package:signals/signals.dart';

void main() {
  group('InteractivePostsViewModel', () {
    late MockPostsRepository repository;
    late InteractivePostsViewModel viewModel;

    Future<InteractivePostsDiff> waitForNextDiff() async {
      return viewModel.interactivePostsDiff
          .toStream()
          .map((value) => value.value)
          .whereNotNull()
          .first
          .timeout(.zero);
    }

    setUp(() {
      repository = MockPostsRepository();
      repository.setupPostsStream();
      viewModel = InteractivePostsViewModel(
        postsRepository: repository,
        disposeDelay: .zero,
      );
    });

    tearDown(() async {
      viewModel.dispose();
      await repository.close();
    });

    group('deletingCount', () {
      test('is zero when no posts exist', () {
        expect(viewModel.deletingCount.value, 0);
      });

      test('is zero when posts exist but no deletions pending', () async {
        repository.emitPosts([post1, post2]);
        await waitForNextDiff();

        expect(viewModel.deletingCount.value, 0);
      });

      test('increments when delete mutation starts', () async {
        final deleteCompleter = Completer<void>();
        when(
          () => repository.deletePost(id: 1),
        ).thenAnswer((_) => deleteCompleter.future);

        repository.emitPosts([post1]);
        final diff = await waitForNextDiff();
        expect(viewModel.deletingCount.value, 0);

        unawaited(diff.current[0].editPostViewModel.deletePost(id: 1));
        await Future<void>.delayed(.zero);

        expect(viewModel.deletingCount.value, 1);

        deleteCompleter.complete();
      });

      test('decrements when delete mutation completes', () async {
        final deleteCompleter = Completer<void>();
        when(
          () => repository.deletePost(id: 1),
        ).thenAnswer((_) => deleteCompleter.future);

        repository.emitPosts([post1]);
        final diff = await waitForNextDiff();

        unawaited(diff.current[0].editPostViewModel.deletePost(id: 1));
        await Future<void>.delayed(.zero);
        expect(viewModel.deletingCount.value, 1);

        deleteCompleter.complete();
        await Future<void>.delayed(.zero);

        expect(viewModel.deletingCount.value, 0);
      });

      test('tracks multiple concurrent deletions', () async {
        final deleteCompleter1 = Completer<void>();
        final deleteCompleter2 = Completer<void>();
        when(
          () => repository.deletePost(id: 1),
        ).thenAnswer((_) => deleteCompleter1.future);
        when(
          () => repository.deletePost(id: 2),
        ).thenAnswer((_) => deleteCompleter2.future);

        repository.emitPosts([post1, post2]);
        final diff = await waitForNextDiff();
        expect(viewModel.deletingCount.value, 0);

        unawaited(diff.current[0].editPostViewModel.deletePost(id: 1));
        await Future<void>.delayed(.zero);
        expect(viewModel.deletingCount.value, 1);

        unawaited(diff.current[1].editPostViewModel.deletePost(id: 2));
        await Future<void>.delayed(.zero);
        expect(viewModel.deletingCount.value, 2);

        deleteCompleter1.complete();
        await Future<void>.delayed(.zero);
        expect(viewModel.deletingCount.value, 1);

        deleteCompleter2.complete();
        await Future<void>.delayed(.zero);
        expect(viewModel.deletingCount.value, 0);
      });
    });

    group('EditPostViewModel lifecycle', () {
      test('creates unique EditPostViewModel for each post', () async {
        repository.emitPosts([post1, post2]);
        final diff = await waitForNextDiff();

        final viewModel1 = diff.current[0].editPostViewModel;
        final viewModel2 = diff.current[1].editPostViewModel;

        expect(viewModel1, isNot(same(viewModel2)));
      });

      test('reuses same EditPostViewModel when post updates', () async {
        repository.emitPosts([Post(id: 1, title: 'Original')]);
        final firstDiff = await waitForNextDiff();
        final firstViewModel = firstDiff.current[0].editPostViewModel;

        repository.emitPosts([Post(id: 1, title: 'Updated')]);
        final secondDiff = await waitForNextDiff();
        final secondViewModel = secondDiff.current[0].editPostViewModel;

        expect(firstViewModel, same(secondViewModel));
      });

      test(
        'disposes EditPostViewModel after delay when post is removed',
        () async {
          const disposeDelay = Duration(milliseconds: 5);
          viewModel = InteractivePostsViewModel(
            postsRepository: repository,
            disposeDelay: disposeDelay,
          );

          repository.emitPosts([post1, post2]);
          final diff = await waitForNextDiff();
          final removedViewModel = diff.current[1].editPostViewModel;

          expect(removedViewModel.isPostDeleted.disposed, isFalse);

          repository.emitPosts([post1]);
          await waitForNextDiff();

          expect(removedViewModel.isPostDeleted.disposed, isFalse);

          await Future<void>.delayed(
            disposeDelay + const .new(milliseconds: 5),
          );

          expect(removedViewModel.isPostDeleted.disposed, isTrue);
        },
      );

      test('disposes all EditPostViewModels when parent is disposed', () async {
        repository.emitPosts([post1, post2]);
        final diff = await waitForNextDiff();

        final viewModels = diff.current
            .map((interactivePost) => interactivePost.editPostViewModel)
            .toList();

        for (final vm in viewModels) {
          expect(vm.isPostDeleted.disposed, isFalse);
        }

        viewModel.dispose();

        for (final vm in viewModels) {
          expect(vm.isPostDeleted.disposed, isTrue);
        }
      });
    });

    group('interactivePostsDiff', () {
      test('first emission treats all posts as current and added', () async {
        final posts = [post1, post2];
        repository.emitPosts(posts);

        final diff = await waitForNextDiff();

        expect(diff.current.posts, posts);
        expect(diff.added.posts, posts);
        expect(diff.removed, isEmpty);
      });

      test('added contains only new posts when posts are added', () async {
        repository.emitPosts([post1]);
        await waitForNextDiff();

        repository.emitPosts([post1, post2]);
        final diff = await waitForNextDiff();

        expect(diff.current.posts, [post1, post2]);
        expect(diff.added.posts, [post2]);
        expect(diff.removed, isEmpty);
      });

      test('removed contains posts that were deleted', () async {
        repository.emitPosts([post1, post2]);
        await waitForNextDiff();

        repository.emitPosts([post1]);
        final diff = await waitForNextDiff();

        expect(diff.current.posts, [post1]);
        expect(diff.added, isEmpty);
        expect(diff.removed.posts, [post2]);
      });

      test('simultaneous add and remove tracked correctly', () async {
        repository.emitPosts([post1, post2]);
        await waitForNextDiff();

        repository.emitPosts([post2, post3]);
        final diff = await waitForNextDiff();

        expect(diff.current.posts, [post2, post3]);
        expect(diff.added.posts, [post3]);
        expect(diff.removed.posts, [post1]);
      });

      test('post data update without id change has no added/removed', () async {
        final originalPost = Post(id: 1, title: 'Original');
        final updatedPost = Post(id: 1, title: 'Updated');

        repository.emitPosts([originalPost]);
        await waitForNextDiff();

        repository.emitPosts([updatedPost]);
        final diff = await waitForNextDiff();

        expect(diff.current.posts, [updatedPost]);
        expect(diff.added, isEmpty);
        expect(diff.removed, isEmpty);
      });

      test('empty stream emits empty diff', () async {
        repository.emitPosts([]);
        final diff = await waitForNextDiff();

        expect(diff.current, isEmpty);
        expect(diff.added, isEmpty);
        expect(diff.removed, isEmpty);
      });
    });
  });
}

class MockPostsRepository extends Mock implements PostsRepository {
  final _postsSubject = BehaviorSubject<List<Post>>();

  void emitPosts(List<Post> posts) => _postsSubject.add(posts);

  void setupPostsStream() {
    when(() => postsStream()).thenAnswer((_) => _postsSubject.stream);
  }

  Future<void> close() async => _postsSubject.close();
}

final Post post1 = Post(id: 1, title: 'Post 1');
final Post post2 = Post(id: 2, title: 'Post 2');
final Post post3 = Post(id: 3, title: 'Post 3');

extension on List<InteractivePost> {
  List<Post> get posts =>
      map((interactivePost) => interactivePost.post).toList();
}
