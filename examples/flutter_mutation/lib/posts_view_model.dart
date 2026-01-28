import 'package:signals/signals_flutter.dart';
import 'posts_repository.dart';

class PostsViewModel {
  PostsViewModel({required PostsRepository postsRepository})
    : _postsRepository = postsRepository;

  final PostsRepository _postsRepository;

  late final StreamSignal<List<Post>> postsStream = streamSignal(
    () => _postsRepository.postsStream(),
  );

  void dispose() {
    postsStream.dispose();
  }
}
