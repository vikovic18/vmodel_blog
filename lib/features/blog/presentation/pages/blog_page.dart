import 'package:blog_app/core/common/widgets/body_text.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snackBar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static const String routeName = "/blog-page";
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

  Future<void> _pullRefresh() async {
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: BodyText(color: AppPallete.whiteColor, size: 25, text: 'Blog App', weight: FontWeight.w600)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddNewBlogPage.routeName);
              },
              icon: const Icon(CupertinoIcons.add_circled))
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(listener: (context, state) {
        if (state is BlogFailure) {
          showSnackBar(context, state.error);
        } else if (state is BlogCreateSuccess) {
          showSnackBar(context, "Blog Created Successfully!");
          // Optionally refetch the blogs if not done elsewhere:
          context.read<BlogBloc>().add(BlogFetchAllBlogs());
        }
      }, builder: (context, state) {
        if (state is BlogLoading) {
          return const Loader();
        }
        if (state is BlogDisplaySuccess) {
          return RefreshIndicator(
            onRefresh: _pullRefresh,
            child: ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return BlogCard(blog: blog, blogBloc: BlocProvider.of<BlogBloc>(context));
                }),
          );
        }
        return const SizedBox();
      }),
    );
  }
}
