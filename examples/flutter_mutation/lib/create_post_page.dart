import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signals/signals_flutter.dart';

import 'create_post_view_model.dart';
import 'posts_repository.dart';
import 'widgets.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _titleController = TextEditingController();
  late final CreatePostViewModel _createPostViewModel;
  VoidCallback? _createPostRemoveListener;

  @override
  void initState() {
    super.initState();
    _createPostViewModel = CreatePostViewModel(
      postsRepository: context.read<PostsRepository>(),
    );
    _initCreatePostMutationListener();
  }

  @override
  void dispose() {
    _createPostViewModel.dispose();
    _createPostRemoveListener?.call();
    _titleController.dispose();
    super.dispose();
  }

  void _initCreatePostMutationListener() {
    _createPostRemoveListener = _createPostViewModel.createPostMutation
        .subscribe((value) {
          if (!mounted) return;

          switch (value) {
            case MutationSuccess<Post>():
              LoadingDialog.hide(context);
              Navigator.of(context).pop();
            case MutationError<Post>():
              LoadingDialog.hide(context);
            case MutationPending():
              LoadingDialog.show(context);
            case _:
              break;
          }
        });
  }

  void _createPost() {
    _createPostViewModel.createPost(title: _titleController.text);
  }

  void _onPopInvokedWithResult(bool didPop, Object? result) {
    if (didPop) return;

    if (!_createPostViewModel.createPostMutation.value.isPending) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _onPopInvokedWithResult,
      child: Scaffold(
        appBar: AppBar(title: const Text('Create Post')),
        body: Padding(
          padding: const .all(16),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              TextField(
                controller: _titleController,
                autofocus: true,
                decoration: const .new(labelText: 'Title'),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => _createPost(),
                child: const Text('Create'),
              ),
              Watch((context) {
                return switch (_createPostViewModel.createPostMutation.value) {
                  MutationError<Post>(:final error) => Column(
                    children: [
                      const SizedBox(height: 16),
                      CrudErrorCard(message: error.toString()),
                    ],
                  ),
                  _ => const SizedBox(),
                };
              }),
            ],
          ),
        ),
      ),
    );
  }
}
