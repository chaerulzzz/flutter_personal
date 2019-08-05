import 'package:flutter_personal/repository/models/post.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class PostEvent extends Equatable {
  PostEvent([List props = const []]) : super(props);
}

class UpdatePost extends PostEvent {
  final Post data;

  UpdatePost(this.data) : super([data]);

  @override
  String toString() => 'Update Post {data: $data}';
}