import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  Future<void> uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;

  BlogLocalDataSourceImpl(this.box);
  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];
    for (int i = 0; i < box.length; i++) {
      blogs.add(BlogModel.fromJson(box.get(i.toString())));
    }
    return blogs;
  }

  @override
  Future<void> uploadLocalBlogs({required List<BlogModel> blogs}) async {
    await box.clear(); // Clears all entries in the box before adding new ones
    for (int i = 0; i < blogs.length; i++) {
      await box.put(i.toString(), blogs[i].toJson());
    }
  }
}
