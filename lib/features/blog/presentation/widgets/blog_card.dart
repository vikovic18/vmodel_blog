// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/core/utils/show_snackBar.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:blog_app/core/common/widgets/body_text.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final BlogBloc blogBloc;
  const BlogCard({
    Key? key,
    required this.blog,
    required this.blogBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, BlogViewerPage.routeName, arguments: blog);
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppPallete.tealColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: BodyText(color: AppPallete.whiteColor, size: 22, text: blog.title, weight: FontWeight.w700)),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AddNewBlogPage.routeName, arguments: blog);
                      },
                      icon: const Icon(Icons.edit, color: AppPallete.whiteColor),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const BodyText(
                                text: 'Delete Blog',
                                color: AppPallete.whiteColor,
                                size: 20,
                                weight: FontWeight.w500,
                              ),
                              content: const BodyText(
                                text: 'Are you sure you want to delete this blog?',
                                color: AppPallete.whiteColor,
                                size: 16,
                                weight: FontWeight.w200,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                BlocBuilder<BlogBloc, BlogState>(
                                  builder: (context, state) {
                                    if (state is BlogLoading) {
                                      return const CircularProgressIndicator(); // Show loading spinner
                                    }
                                    if (state is BlogDeleteSuccess) {
                                      showSnackBar(context, state.message);
                                    }
                                    if (state is BlogFailure) {
                                      showSnackBar(context, state.error);
                                    }
                                    return TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        blogBloc.add(BlogDelete(blog.id)); // Trigger the BlogDelete event
                                      },
                                      child: const Text('Delete'),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.delete, color: AppPallete.whiteColor),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            BodyText(color: AppPallete.whiteColor.withOpacity(0.7), size: 16, text: blog.subTitle, weight: FontWeight.w500),
            const SizedBox(height: 12),
            BodyText(
              color: AppPallete.whiteColor.withOpacity(0.5),
              size: 14,
              text: DateFormat('MMMM dd, yyyy').format(blog.dateCreated),
              weight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
