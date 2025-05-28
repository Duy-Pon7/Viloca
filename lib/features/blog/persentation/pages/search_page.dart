import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietour/core/common/widgets/loader.dart';
import 'package:vietour/core/theme/app_pallete.dart';
import 'package:vietour/features/blog/persentation/bloc/blog_bloc.dart';
import 'package:vietour/features/blog/persentation/widgets/blog_card.dart';

class SearchPage extends StatelessWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const SearchPage(),
  );

  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Blogs')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search blogs...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                // Trigger search logic here
                context.read<BlogBloc>().add(
                  BlogSearchBlogs(query: value),
                );
              },
            ),
          ),
          Expanded(
            child: BlocConsumer<BlogBloc, BlogState>(
              listener: (context, state) {
                if (state is BlogFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              builder: (context, state) {
                if (state is BlogLoading) {
                  return const Loader();
                }
                if (state is BlogDisplaySuccess) {
                  return ListView.builder(
                    itemCount: state.blogs.length,
                    itemBuilder: (context, index) {
                      final blog = state.blogs[index];
                      return BlogCard(
                        blog: blog,
                        color:
                            index % 2 == 0
                                ? AppPallete.gradient1
                                : AppPallete.gradient2,
                      );
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
