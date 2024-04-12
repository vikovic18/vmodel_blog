import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecases/usecase.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteBlog implements UseCase<String, DeleteBlogParams> {
  final BlogRepository blogRepository;

  DeleteBlog(this.blogRepository);
  @override
  Future<Either<Failure, String>> call(DeleteBlogParams params) async {
    return await blogRepository.deleteBlog(blogId: params.blogId);
  }
}

class DeleteBlogParams {
  final String blogId;

  DeleteBlogParams(this.blogId);
}
