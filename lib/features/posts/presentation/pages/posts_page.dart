import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../bloc/posts_bloc.dart';
import '../widgets/post_list_item.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PostsBloc>().add(GetPostsEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced BLoC Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => context.read<ThemeBloc>().toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<PostsBloc>().add(GetPostsEvent()),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search posts...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<PostsBloc>().add(const SearchPostsEvent(''));
                  },
                ),
              ),
              onChanged: (value) {
                context.read<PostsBloc>().add(SearchPostsEvent(value));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<PostsBloc, PostsState>(
              builder: (context, state) {
                if (state is PostsLoading) {
                  return const Center(
                    child: SpinKitFadingCircle(
                      color: Colors.indigo,
                      size: 50.0,
                    ),
                  );
                } else if (state is PostsLoaded) {
                  if (state.posts.isEmpty) {
                    return const Center(child: Text('No posts found.'));
                  }
                  return ListView.builder(
                    itemCount: state.posts.length,
                    itemBuilder: (context, index) {
                      return PostListItem(post: state.posts[index]);
                    },
                  );
                } else if (state is PostsError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => context.read<PostsBloc>().add(GetPostsEvent()),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
