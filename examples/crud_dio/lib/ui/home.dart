import 'package:crud_dio/model/post_model.dart';
import 'package:crud_dio/signals/post_signals.dart';
import 'package:crud_dio/ui/home_add_or_edit.dart';
import 'package:crud_dio/ui/home_detail.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Watch((context, _) {
        final posts = postsService.posts;
        if (posts.value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (posts.value.value == null) {
          return const Center(child: Text('No Posts'));
        }

        if (posts.value.hasError) {
          return Center(child: Text(posts.value.error.toString()));
        }
        return ListView.builder(
          itemCount: posts.value.value?.length,
          itemBuilder: ((context, index) {
            final Post post = posts.value.value![index];
            return ListTile(
              title: Text(post.title ?? ''),
              subtitle: Text(post.body ?? ''),
              onTap: () {
                postsService.getPost(id: post.id!);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => HomeDetail(id: post.id!)),
                );
              },
            );
          }),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const HomeAddOrEdit()),
          );
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
