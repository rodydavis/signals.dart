import 'package:signals/signals_flutter.dart';
import 'posts_repository.dart';

class CreatePostViewModel {
  CreatePostViewModel({required PostsRepository postsRepository})
    : _postsRepository = postsRepository;

  final PostsRepository _postsRepository;

  final createPostMutation = MutationSignal<Post>(
    canRun: (value) => !value.isSuccess,
  );

  Future<void> createPost({required String title}) =>
      createPostMutation.run(() => _postsRepository.createPost(title: title));

  void dispose() {
    createPostMutation.dispose();
  }
}
