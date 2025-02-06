import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:signals_mvi_example/posts/data/post_error.dart';
import 'package:signals_mvi_example/posts/data/post_model.dart';
import 'package:signals_mvi_example/posts/data/posts_repository.dart';
import 'package:signals_mvi_example/posts/view_model/posts_view_model.dart';

class MockPostsRepository extends Mock implements PostsRepository {}

void main() {
  late PostsViewModel viewModel;
  late MockPostsRepository postsRepository;

  setUp(() {
    postsRepository = MockPostsRepository();
    viewModel = PostsViewModel(postsRepository: postsRepository);
  });

  tearDown(() {
    viewModel.dispose();
  });

  test('View model initial state should be PostsLoading', () {
    expect(viewModel.state.value, isA<PostsLoading>());
  });

  test('test FetchPosts event success', () {
    fakeAsync((async) {
      final posts = [
        const Post(userId: 1, id: 1, title: 'title', body: 'body')
      ];

      when(() => postsRepository.fetchPosts()).thenAnswer(
        (_) => Future.value(Result.success(posts)),
      );

      final viewModel = PostsViewModel(postsRepository: postsRepository)
        ..addEvent(FetchPosts());

      expect(viewModel.state.value, isA<PostsLoading>());

      async.flushMicrotasks();

      expect(viewModel.state.value, PostsLoaded(posts));
    });
  });

  test('test FetchPosts event error', () {
    fakeAsync((async) {
      when(() => postsRepository.fetchPosts()).thenAnswer(
        (_) => Future.value(const Result.error(PostError.unknown)),
      );

      final viewModel = PostsViewModel(postsRepository: postsRepository)
        ..addEvent(FetchPosts());

      expect(viewModel.state.value, isA<PostsLoading>());

      async.flushMicrotasks();

      expect(viewModel.state.value, const PostsError(PostError.unknown));
    });
  });
}
