import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietour/core/common/widgets/loader.dart';
import 'package:vietour/core/theme/app_pallete.dart';
import 'package:vietour/core/utils/show_snackbar.dart';
import 'package:vietour/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vietour/features/blog/persentation/bloc/blog_bloc.dart';
import 'package:vietour/features/blog/persentation/pages/add_new_blog_page.dart';
import 'package:vietour/features/blog/persentation/widgets/blog_card.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const BlogPage(),
  );
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hi, Duy'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.add_circled),
            onPressed: () {
              Navigator.push(
                context,
                AddNewBlogPage.route(),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogout());
            },
            child: Text('Logout'),
          ),
        ],
      ),
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
                // Handle search logic here
                print('Search query: $value');
              },
            ),
          ),
          Expanded(
            child: BlocConsumer<BlogBloc, BlogState>(
              listener: (context, state) {
                if (state is BlogFailure) {
                  showSnackBar(context, state.error);
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
