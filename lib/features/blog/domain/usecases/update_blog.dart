import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecases/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateBlog implements UseCase<Blog, UpdateBlogParams> {
  final BlogRepository blogRepository;

  UpdateBlog(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(UpdateBlogParams params) async {
    return await blogRepository.updateBlog(
        title: params.title, subTitle: params.subTitle, body: params.body, dateCreated: params.dateCreated, blogId: params.blogId);
  }
}

class UpdateBlogParams {
  final String blogId;
  final String title;
  final String subTitle;
  final String body;
  final DateTime dateCreated;

  UpdateBlogParams(this.blogId, this.title, this.subTitle, this.body, this.dateCreated);
}
