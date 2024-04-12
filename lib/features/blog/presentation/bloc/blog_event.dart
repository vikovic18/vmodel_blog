part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogCreate extends BlogEvent {
  final String title;
  final String subTitle;
  final String body;

  BlogCreate(this.title, this.subTitle, this.body);
}

final class BlogFetchAllBlogs extends BlogEvent {}

final class BlogDelete extends BlogEvent {
  final String blogId;

  BlogDelete(this.blogId);
}

final class BlogUpdate extends BlogEvent {
  final String title;
  final String subTitle;
  final String body;
  final String blogId;
  final DateTime dateCreated;

  BlogUpdate(this.title, this.subTitle, this.body, this.blogId, this.dateCreated);
}
