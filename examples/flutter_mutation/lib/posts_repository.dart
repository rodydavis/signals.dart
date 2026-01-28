import 'dart:async';
import 'package:rxdart/rxdart.dart';

class PostsRepository {
  PostsRepository({
    Duration delayDuration = const .new(milliseconds: 1500),
    int defaultPostsCount = 6,
    PostRepositoryResponseBehavior responseBehavior = .alternate,
  }) : _delayDuration = delayDuration,
       _responseBehavior = responseBehavior {
    _addDefaultPosts(count: defaultPostsCount);
  }

  final Duration _delayDuration;
  final PostRepositoryResponseBehavior _responseBehavior;

  int _lastPostId = 0;

  int _getNextId() {
    _lastPostId++;
    return _lastPostId;
  }

  Future<void> _delay() {
    return Future.delayed(_delayDuration);
  }

  final Map<int, Post> _posts = {};

  late final BehaviorSubject<List<Post>> _postsStreamController = .new(
    onListen: () {
      _postsStreamController.add(_posts.values.toList());
    },
  );

  final Map<_PostRepositoryAction, bool> _shouldThrowForAction = {
    _PostRepositoryAction.createPost: true,
    _PostRepositoryAction.updatePost: true,
    _PostRepositoryAction.deletePost: true,
  };

  /// Add a delay and throw a fake error every odd call.
  Future<T> _effectiveActionFn<T>({
    required Future<T> Function() fn,
    required _PostRepositoryAction action,
  }) async {
    await _delay();

    final shouldThrow = switch (_responseBehavior) {
      .alwaysSucceed => false,
      .alwaysFail => true,
      .alternate => _shouldThrowForAction[action]!,
    };

    if (shouldThrow) {
      _shouldThrowForAction[action] = false;
      throw PostsRepositoryException('Fake error');
    }

    _shouldThrowForAction[action] = true;

    return fn();
  }

  void _addDefaultPosts({required int count}) {
    for (var i = 1; i <= count; i++) {
      final id = _getNextId();
      final post = Post(id: id, title: 'Post $id');
      _posts[post.id] = post;
    }
  }

  Future<Post> createPost({required String title}) {
    return _effectiveActionFn<Post>(
      action: _PostRepositoryAction.createPost,
      fn: () async {
        final post = Post(id: _getNextId(), title: title);
        _posts[post.id] = post;
        _postsStreamController.add(_posts.values.toList());
        return post;
      },
    );
  }

  Future<Post> updatePost({required Post post}) {
    return _effectiveActionFn<Post>(
      action: _PostRepositoryAction.updatePost,
      fn: () async {
        _posts[post.id] = post;
        _postsStreamController.add(_posts.values.toList());
        return post;
      },
    );
  }

  Future<void> deletePost({required int id}) {
    return _effectiveActionFn<void>(
      action: _PostRepositoryAction.deletePost,
      fn: () async {
        final post = _posts.remove(id);
        _postsStreamController.add(_posts.values.toList());

        if (post == null) {
          throw PostsRepositoryException('Post not found');
        }
      },
    );
  }

  Stream<List<Post>> postsStream() {
    return _postsStreamController.stream;
  }

  Future<void> dispose() async {
    await _postsStreamController.close();
  }
}

class PostsRepositoryException implements Exception {
  PostsRepositoryException(this.message);

  final String message;

  @override
  String toString() => 'PostsRepositoryException: $message';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is PostsRepositoryException && other.message == message;
  }

  @override
  int get hashCode => Object.hashAll([message]);
}

class Post {
  Post({required this.id, required this.title});

  final int id;
  final String title;

  Post copyWith({int? id, String? title}) {
    return Post(id: id ?? this.id, title: title ?? this.title);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is Post && other.id == id && other.title == title;
  }

  @override
  int get hashCode => Object.hashAll([id, title]);
}

enum _PostRepositoryAction { createPost, updatePost, deletePost }

enum PostRepositoryResponseBehavior { alwaysSucceed, alwaysFail, alternate }
