import 'package:flutter_personal/repository/models/post.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class PostState extends Equatable {
  PostState([List props = const []]) : super(props);
}

class PostLoading extends PostState {
  @override
  String toString() => 'Post Loading';
}

class PostLoaded extends PostState {
  final Post data;

  PostLoaded(this.data) : super([data]);

  @override
  String toString() => 'Post Loaded {data: $data}';
}