import 'dart:async';
import 'package:flutter_personal/repository/api/services.dart';

import './post.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class PostBloc extends Bloc<PostEvent, PostState> {

  PostRepository repository = PostRepository();

  PostBloc({@required this.repository});

  @override
  PostState get initialState => PostLoading();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is UpdatePost) {
      yield PostLoaded(event.data);
    }
  }
}