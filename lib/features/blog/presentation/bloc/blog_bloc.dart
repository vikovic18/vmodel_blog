import 'package:blog_app/core/usecases/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/create_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/delete_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/fetch_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/update_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final CreateBlog _createBlog;
  final FetchAllBlogs _fetchAllBlogs;
  final DeleteBlog _deleteBlog;
  final UpdateBlog _updateBlog;
  List<Blog> _blogs = [];
  BlogBloc({required CreateBlog createBlog, required FetchAllBlogs fetchAllBlogs, required DeleteBlog deleteBlog, required UpdateBlog updateBlog})
      : _createBlog = createBlog,
        _fetchAllBlogs = fetchAllBlogs,
        _deleteBlog = deleteBlog,
        _updateBlog = updateBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogCreate>(_onBlogCreate);
    on<BlogFetchAllBlogs>(_onFetchAllBlogs);
    on<BlogDelete>(_onBlogDelete);
    on<BlogUpdate>(_onBlogUpdate);
  }

  void _onBlogCreate(BlogCreate event, Emitter<BlogState> emit) async {
    final result = await _createBlog(CreateBlogParams(event.title, event.subTitle, event.body));
    result.fold((l) => emit(BlogFailure(l.message)), (r) {
      _blogs.insert(0, r);
      emit(BlogCreateSuccess(r));
      emit(BlogDisplaySuccess(List.from(_blogs)));
    });
  }

  void _onFetchAllBlogs(BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
    final result = await _fetchAllBlogs(NoParams());
    result.fold((l) => emit(BlogFailure(l.message)), (r) {
      _blogs = r;
      emit(BlogDisplaySuccess(_blogs));
    });
  }

  void _onBlogDelete(BlogDelete event, Emitter<BlogState> emit) async {
    final result = await _deleteBlog(DeleteBlogParams(event.blogId));
    result.fold((l) => emit(BlogFailure(l.message)), (r) {
      int index = _blogs.indexWhere((blog) => blog.id == event.blogId);
      if (index != -1) {
        _blogs.removeAt(index);
      }
      emit(BlogDeleteSuccess(r));
      emit(BlogDisplaySuccess(List.from(_blogs)));
    });
  }

  void _onBlogUpdate(BlogUpdate event, Emitter<BlogState> emit) async {
    final result = await _updateBlog(UpdateBlogParams(event.blogId, event.title, event.subTitle, event.body, event.dateCreated));
    result.fold((l) => emit(BlogFailure(l.message)), (r) {
      _blogs.insert(0, r);
      emit(BlogUpdateSuccess(r));
      emit(BlogDisplaySuccess(List.from(_blogs)));
    });
  }
}
