import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
@CopyWith()
class Post {
  const Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  Map<String, dynamic> toJson() => _$PostToJson(this);
}