import 'package:crud_dio/model/post_model.dart';
import 'package:crud_dio/service/api_service.dart';
import 'package:signals/signals.dart';

class PostService {
  late final posts = futureSignal(() => getPosts(), autoDispose: false);
  final post = asyncSignal<Post?>(AsyncState.data(null));
  final postAddOrEdit = asyncSignal<Post?>(AsyncState.data(null));
  final delete = asyncSignal<void>(AsyncState.data(null));

  Future<List<Post>?> getPosts() async {
    final result = await RestClient().getPosts();
    return result;
  }

  Future<void> getPost({required int id}) async {
    post.value = AsyncState.loading();
    try {
      final result = await RestClient().getPost(id);
      post.value = AsyncState.data(result);
    } catch (e, st) {
      post.value = AsyncState.error(e, st);
    }
  }

  Future<void> createPost({required Post post}) async {
    postAddOrEdit.value = AsyncState.loading();
    try {
      final result = await RestClient().createPost(post);
      postAddOrEdit.value = AsyncState.data(result);
      posts.refresh();
    } catch (e, st) {
      postAddOrEdit.value = AsyncState.error(e, st);
    }
  }

  Future<void> updatePost({required int id, required Post post}) async {
    postAddOrEdit.value = AsyncState.loading();
    try {
      final result = await RestClient().updatePost(id, post);
      postAddOrEdit.value = AsyncState.data(result);
      posts.refresh();
    } catch (e, st) {
      postAddOrEdit.value = AsyncState.error(e, st);
    }
  }

  Future<void> deletePost({required int id}) async {
    delete.value = AsyncState.loading();
    try {
      await RestClient().deletePost(id);
      delete.value = AsyncState.data(null);
      posts.refresh();
    } catch (e, st) {
      delete.value = AsyncState.error(e, st);
    }
  }
}

final postsService = PostService();
