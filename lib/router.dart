import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case BlogPage.routeName:
      return MaterialPageRoute(builder: (_) => const BlogPage());
    case AddNewBlogPage.routeName:
      final blog = routeSettings.arguments as Blog?;
      return MaterialPageRoute(builder: (_) => AddNewBlogPage(blog: blog));
    case BlogViewerPage.routeName:
      var blog = routeSettings.arguments as Blog;
      return MaterialPageRoute(builder: (_) => BlogViewerPage(blog: blog));
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("Screen does not exist"),
                ),
              ));
  }
}
