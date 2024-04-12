import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/utils/show_snackBar.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  static const String routeName = "/add-new-blog-page";
  final Blog? blog;
  const AddNewBlogPage({super.key, this.blog});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController subTitleController = TextEditingController();
  late TextEditingController bodyController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.blog?.title ?? '');
    subTitleController = TextEditingController(text: widget.blog?.subTitle ?? '');
    bodyController = TextEditingController(text: widget.blog?.body ?? '');
  }

  void _saveBlog() {
    if (formKey.currentState!.validate()) {
      if (widget.blog != null) {
        // Update existing blog
        context.read<BlogBloc>().add(BlogUpdate(
              titleController.text.trim(),
              subTitleController.text.trim(),
              bodyController.text.trim(),
              widget.blog!.id,
              widget.blog!.dateCreated,
            ));
      } else {
        // Create new blog
        context.read<BlogBloc>().add(BlogCreate(
              titleController.text.trim(),
              subTitleController.text.trim(),
              bodyController.text.trim(),
            ));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    subTitleController.dispose();
    bodyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _saveBlog();
              },
              icon: const Icon(Icons.done_rounded))
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<BlogBloc, BlogState>(
          listener: ((context, state) {
            if (state is BlogFailure) {
              showSnackBar(context, state.error);
            }
            if (state is BlogCreateSuccess) {
              Navigator.pop(context);
            }
            if (state is BlogUpdateSuccess) {
              Navigator.pop(context);
            }
          }),
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Loader();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      BlogEditor(controller: titleController, hintText: 'Blog title'),
                      const SizedBox(height: 12),
                      BlogEditor(controller: subTitleController, hintText: 'Blog subtitle'),
                      const SizedBox(height: 12),
                      BlogEditor(controller: bodyController, hintText: 'Blog content'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
