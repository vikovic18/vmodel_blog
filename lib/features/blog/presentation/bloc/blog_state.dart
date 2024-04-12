part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogFailure extends BlogState {
  final String error;
  BlogFailure(this.error);
}

final class BlogCreateSuccess extends BlogState {
  final Blog blog; // Newly created blog
  BlogCreateSuccess(this.blog);
}

final class BlogDisplaySuccess extends BlogState {
  final List<Blog> blogs;
  BlogDisplaySuccess(this.blogs);
}

final class BlogDeleteSuccess extends BlogState {
  final String message;
  BlogDeleteSuccess(this.message);
}

final class BlogUpdateSuccess extends BlogState {
  final Blog blog; // Newly created blog
  BlogUpdateSuccess(this.blog);
}
