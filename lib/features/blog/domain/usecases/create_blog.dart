import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecases/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class CreateBlog implements UseCase<Blog, CreateBlogParams> {
  final BlogRepository blogRepository;

  CreateBlog(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(CreateBlogParams params) async {
    return await blogRepository.createBlog(title: params.title, subTitle: params.subTitle, body: params.body);
  }
}

class CreateBlogParams {
  final String title;
  final String subTitle;
  final String body;

  CreateBlogParams(this.title, this.subTitle, this.body);
}
