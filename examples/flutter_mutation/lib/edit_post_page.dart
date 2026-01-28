import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signals/signals_flutter.dart';

import 'edit_post_view_model.dart';
import 'posts_repository.dart';
import 'widgets.dart';

class EditPostPage extends StatefulWidget {
  const EditPostPage({super.key, required this.post});

  final Post post;

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final _titleController = TextEditingController();
  late final EditPostViewModel _editPostViewModel;
  VoidCallback? _updatePostRemoveListener;
  VoidCallback? _deletePostRemoveListener;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.post.title;
    _editPostViewModel = EditPostViewModel(
      postsRepository: context.read<PostsRepository>(),
    );
    _initUpdatePostMutationListener();
    _initDeletePostMutationListener();
  }

  @override
  void dispose() {
    _editPostViewModel.dispose();
    _updatePostRemoveListener?.call();
    _deletePostRemoveListener?.call();
    _titleController.dispose();
    super.dispose();
  }

  void _initUpdatePostMutationListener() {
    _updatePostRemoveListener = _editPostViewModel.updatePostMutation.subscribe(
      (value) {
        if (!mounted) return;

        switch (value) {
          case MutationSuccess():
            showSuccessSnackBar(
              context: context,
              message: 'Post updated successfully',
            );
          case MutationError<Post>(:final error):
            showErrorSnackBar(
              context: context,
              message: 'Error updating post',
              error: error,
            );
          case _:
            break;
        }
      },
    );
  }

  void _initDeletePostMutationListener() {
    _deletePostRemoveListener = _editPostViewModel.deletePostMutation.subscribe(
      (value) {
        if (!mounted) return;

        switch (value) {
          case MutationSuccess():
            Navigator.of(context).pop();
            showSuccessSnackBar(
              context: context,
              message: 'Post deleted successfully',
            );
          case MutationError(:final error):
            showErrorSnackBar(
              context: context,
              message: 'Error deleting post',
              error: error,
            );
          case _:
            break;
        }
      },
    );
  }

  void _updatePost() {
    _editPostViewModel.updatePost(
      post: widget.post.copyWith(title: _titleController.text),
    );
  }

  void _deletePost() {
    _editPostViewModel.deletePost(id: widget.post.id);
  }

  void _onPopInvokedWithResult(bool didPop, Object? result) {
    if (didPop) return;

    if (!_editPostViewModel.hasPendingMutations.value) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _onPopInvokedWithResult,
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Post')),
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
              Row(
                children: [
                  Expanded(
                    child: Watch((context) {
                      final updatePostMutation =
                          _editPostViewModel.updatePostMutation;

                      return LoadingFilledButton(
                        isLoading: updatePostMutation.value.isPending,
                        isEnabled: updatePostMutation.canRun.value,
                        label: 'Update',
                        onPressed: () => _updatePost(),
                      );
                    }),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Watch((context) {
                      final deletePostMutation =
                          _editPostViewModel.deletePostMutation;

                      return LoadingFilledButton(
                        isLoading: deletePostMutation.value.isPending,
                        isEnabled: deletePostMutation.canRun.value,
                        label: 'Delete',
                        onPressed: () => _deletePost(),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
