import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/posts/models/post_model.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<NavigateToPostDetailsEvent>(navigateToPostDetailsEvent);
  }

  FutureOr<void> navigateToPostDetailsEvent(NavigateToPostDetailsEvent event, Emitter<PostsState> emit) {
    emit(NavigateToPostDetailsState(post: event.post));
  }
}
