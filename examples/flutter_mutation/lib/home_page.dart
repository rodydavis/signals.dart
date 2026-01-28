import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'create_post_page.dart';
import 'interactive_posts_view_model.dart';
import 'posts_tab_view.dart';
import 'posts_repository.dart';
import 'posts_view_model.dart';
import 'interactive_posts_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateToCreatePost() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => const CreatePostPage()));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiProvider(
      providers: [
        Provider<PostsViewModel>(
          create: (context) =>
              PostsViewModel(postsRepository: context.read<PostsRepository>()),
          dispose: (context, value) => value.dispose(),
        ),
        Provider<InteractivePostsViewModel>(
          create: (context) => InteractivePostsViewModel(
            postsRepository: context.read<PostsRepository>(),
          ),
          dispose: (context, value) => value.dispose(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Posts'),
                Tab(text: 'Interactive Posts'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: const [
              _KeepAliveTab(child: PostsTabView()),
              _KeepAliveTab(child: InteractivePostsTabView()),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _navigateToCreatePost,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class _KeepAliveTab extends StatefulWidget {
  const _KeepAliveTab({required this.child});

  final Widget child;

  @override
  State<_KeepAliveTab> createState() => _KeepAliveTabState();
}

class _KeepAliveTabState extends State<_KeepAliveTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
