import 'package:blog_app/api/domain/graphql_client.dart';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> createBlog(BlogModel blog);
  Future<List<BlogModel>> fetchAllBlogs();
  Future<String> deleteBlog(String blogId);
  Future<BlogModel> updateBlog(BlogModel blog, String blogId);
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final GraphClient graphClient;

  BlogRemoteDataSourceImpl({required this.graphClient});
  @override
  Future<BlogModel> createBlog(BlogModel blog) async {
    const String mutation = '''
      mutation createBlogPost(\$title: String!, \$subTitle: String!, \$body: String!) {
        createBlog(title: \$title, subTitle: \$subTitle, body: \$body) {
          success
          blogPost {
            id
            title
            subTitle
            body
            dateCreated
          }
        }
      }
    ''';
    final variables = {
      'title': blog.title,
      'subTitle': blog.subTitle,
      'body': blog.body,
    };
    try {
      final result = await graphClient.mutate(mutation, variables: variables);

      if (result.hasException) {
        throw ServerException(result.exception.toString());
      }

      final blogData = result.data?['createBlog']['blogPost'];
      return BlogModel.fromMap(blogData);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> fetchAllBlogs() async {
    const String query = '''
    query fetchAllBlogs {
      allBlogPosts {
        id
        title
        subTitle
        body
        dateCreated
      }
    }
  ''';
    try {
      final result = await graphClient.query(query);

      if (result.hasException) {
        throw ServerException(result.exception.toString());
      }

      final blogDataList = result.data?['allBlogPosts'] as List<dynamic>;
      List<BlogModel> blogs = blogDataList.map((blogData) => BlogModel.fromMap(blogData)).toList();

      // Sort the blogs by dateCreated in descending order (latest first)
      blogs.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
      return blogs;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> deleteBlog(String blogId) async {
    const String mutation = '''
      mutation deleteBlogPost(\$blogId: String!) {
        deleteBlog(blogId: \$blogId) {
          success
        }
      }
    ''';
    final variables = {'blogId': blogId};
    try {
      final result = await graphClient.mutate(mutation, variables: variables);

      if (result.hasException) {
        throw ServerException(result.exception.toString());
      }

      final success = result.data?['deleteBlog']['success'];
      if (success == true) {
        return 'Blog deleted successfully';
      } else {
        return 'Failed to delete blog';
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<BlogModel> updateBlog(BlogModel blog, String blogId) async {
    const String mutation = '''
    mutation updateBlogPost(\$blogId: String!, \$title: String!, \$subTitle: String!, \$body: String!) {
      updateBlog(blogId: \$blogId, title: \$title, subTitle: \$subTitle, body: \$body) {
        success
        blogPost {
          id
          title
          subTitle
          body
          dateCreated
        }
      }
    }
  ''';
    final variables = {
      'blogId': blogId,
      'title': blog.title,
      'subTitle': blog.subTitle,
      'body': blog.body,
    };

    try {
      final result = await graphClient.mutate(mutation, variables: variables);

      if (result.hasException) {
        throw ServerException(result.exception.toString());
      }

      final blogData = result.data?['updateBlog']['blogPost'];
      return BlogModel.fromMap(blogData);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
