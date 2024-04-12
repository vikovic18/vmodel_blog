import 'package:blog_app/core/common/widgets/body_text.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:intl/intl.dart';

class BlogViewerPage extends StatelessWidget {
  static const String routeName = "/blog-viewer-page";
  final Blog blog;

  const BlogViewerPage({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BodyText(text: 'Blog Details', size: 25, weight: FontWeight.w400, color: AppPallete.whiteColor),
        backgroundColor: AppPallete.blackColor,
        iconTheme: const IconThemeData(color: AppPallete.whiteColor),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyText(
                text: blog.title,
                color: AppPallete.whiteColor,
                size: 24,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              BodyText(
                text: DateFormat('MMMM dd, yyyy').format(blog.dateCreated),
                color: AppPallete.whiteColor,
                size: 14,
                weight: FontWeight.w300,
              ),
              const SizedBox(height: 20),
              BodyText(
                text: blog.subTitle,
                color: AppPallete.tealColor,
                weight: FontWeight.w500,
                size: 18,
              ),
              const Divider(height: 30, thickness: 2, color: AppPallete.grayColor),
              BodyText(
                text: blog.body,
                size: 16,
                weight: FontWeight.w400,
                color: AppPallete.whiteColor,
                letterSpacing: 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
