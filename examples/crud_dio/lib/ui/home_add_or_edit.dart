import 'package:crud_dio/model/post_model.dart';
import 'package:crud_dio/signals/post_signals.dart';
import 'package:flutter/material.dart';

class HomeAddOrEdit extends StatefulWidget {
  final int? id;
  const HomeAddOrEdit({super.key, this.id});

  @override
  State<HomeAddOrEdit> createState() => _HomeAddEditState();
}

class _HomeAddEditState extends State<HomeAddOrEdit> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  Post? _post;
  void Function()? _cleanup;

  @override
  void initState() {
    if (widget.id != null) {
      _post = postsService.post.value.value;
      _title = TextEditingController(
        text: postsService.post.value.value?.title,
      );
      _description = TextEditingController(
        text: postsService.post.value.value?.body,
      );
    }
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _cleanup = postsService.postAddOrEdit.subscribe((_) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.hideCurrentSnackBar();
        if (postsService.postAddOrEdit.value.hasError) {
          messenger.showSnackBar(
            SnackBar(
                backgroundColor: Colors.red,
                content:
                    Text(postsService.postAddOrEdit.value.error.toString())),
          );
        } else if (postsService.postAddOrEdit.value.isLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Container(
                color: Colors.grey.withValues(alpha: 0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              );
            },
          );
        } else if (postsService.postAddOrEdit.value.hasValue) {
          messenger.showSnackBar(
            const SnackBar(
                backgroundColor: Colors.green, content: Text('Saved')),
          );
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              Navigator.of(context).pop();
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _cleanup?.call();
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            const Text('Title'),
            TextFormField(
              controller: _title,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: const InputDecoration(hintText: 'Put Title Here'),
            ),
            const SizedBox(height: 20),
            const Text('Description'),
            TextFormField(
              controller: _description,
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration:
                  const InputDecoration(hintText: 'Put Description Here'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  if (widget.id == null) {
                    postsService.createPost(
                      post: Post(
                        title: _title.text,
                        body: _description.text,
                        userId: 1,
                      ),
                    );
                  } else {
                    postsService.updatePost(
                      id: widget.id!,
                      post: _post!.copyWith(
                        title: _title.text,
                        body: _description.text,
                      ),
                    );
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text(widget.id == null ? 'Create' : 'Save'),
            )
          ],
        ),
      ),
    );
  }
}
