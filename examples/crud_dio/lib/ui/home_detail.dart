import 'package:crud_dio/signals/post_signals.dart';
import 'package:crud_dio/ui/home_add_or_edit.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class HomeDetail extends StatefulWidget {
  final int id;
  const HomeDetail({super.key, required this.id});

  @override
  State<HomeDetail> createState() => _DetailPostState();
}

class _DetailPostState extends State<HomeDetail> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      postsService.delete.subscribe((_) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.hideCurrentSnackBar();
        if (postsService.delete.value.hasError) {
          messenger.showSnackBar(
            SnackBar(
                backgroundColor: Colors.red,
                content: Text(postsService.delete.value.error.toString())),
          );
        } else if (postsService.delete.value.isLoading) {
          messenger.showSnackBar(
            const SnackBar(
              backgroundColor: Colors.blue,
              content: Text('Loading...'),
            ),
          );
        } else if (postsService.delete.value.hasValue) {
          messenger.showSnackBar(
            const SnackBar(
                backgroundColor: Colors.green, content: Text('Deleted')),
          );
          Navigator.of(context).pop();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final post = postsService.post.value;
      return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () => postsService.deletePost(id: post.value!.id!),
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => HomeAddOrEdit(id: post.value!.id!),
                  ),
                );
              },
              child: const Text('Edit'),
            ),
          ],
        ),
        body: post.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.value?.title ?? '',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(post.value?.body ?? ''),
                  ],
                ),
              ),
      );
    });
  }
}
