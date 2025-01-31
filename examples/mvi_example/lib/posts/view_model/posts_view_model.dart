import 'package:signals_mvi_example/core/base_view_model.dart';
import 'package:signals_mvi_example/posts/data/posts_repository.dart';
import 'package:signals_mvi_example/posts/view_model/posts_effect.dart';
import 'package:signals_mvi_example/posts/view_model/posts_event.dart';
import 'package:signals_mvi_example/posts/view_model/posts_state.dart';

export 'posts_effect.dart';
export 'posts_event.dart';
export 'posts_state.dart';

final class PostsViewModel
    extends BaseViewModel<PostsState, PostsEvent, PostsEffect> {
  PostsViewModel({
    required PostsRepository postsRepository,
  })  : _postsRepository = postsRepository,
        super(const PostsLoading());

  final PostsRepository _postsRepository;

  @override
  void onEvent(PostsEvent event) => switch (event) {
        FetchPosts() => _onFetchPosts(),
      };

  Future<void> _onFetchPosts() async {
    updateState(const PostsLoading());

    final result = await _postsRepository.fetchPosts();

    if (result.isSuccess()) {
      updateState(PostsLoaded(result.tryGetSuccess()!));
      return;
    }

    updateState(PostsError(result.tryGetError()!));
  }
}
