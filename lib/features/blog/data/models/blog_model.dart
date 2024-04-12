import 'dart:convert';

import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({required super.id, required super.title, required super.subTitle, required super.body, required super.dateCreated});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'subTitle': subTitle,
      'body': body,
      'dateCreated': dateCreated.toIso8601String(),
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
        id: map['id'] as String,
        title: map['title'] as String,
        subTitle: map['subTitle'] as String,
        body: map['body'] as String,
        dateCreated: DateTime.parse(map['dateCreated']));
  }

  String toJson() => json.encode(toMap());

  factory BlogModel.fromJson(String source) => BlogModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
