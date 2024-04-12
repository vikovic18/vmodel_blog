import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> createBlog({required String title, required String subTitle, required String body});
  Future<Either<Failure, List<Blog>>> fetchAllBlogs();
  Future<Either<Failure, String>> deleteBlog({required String blogId});
  Future<Either<Failure, Blog>> updateBlog(
      {required String title, required String subTitle, required String body, required DateTime dateCreated, required String blogId});
}
