import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/posts/controllers/posts_controller.dart';
import 'package:news_app/features/posts/controllers/repositories/posts_repository.dart';

import '../../../../core/common/network_info.dart';
import '../../../posts/models/post_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoadingState()) {
    //initial event ... to fetch all home screen data..............
    on<HomeInitialEvent>(homeInitialEvent);
  }
  final PostsController _postsController =
      PostsController(postsRepo: PostsRepo());

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    List<Post> breakingNewsPosts = [];
    List<Post> recommendedgNewsPosts = [];
    DataState response = await _postsController.fetchAllPosts();
    if (response is DataSuccess) {
      breakingNewsPosts = response.data as List<Post>;
      recommendedgNewsPosts = List.from(breakingNewsPosts);
      // recommendedgNewsPosts = response.data as List<Post>;
      recommendedgNewsPosts.shuffle();
      emit(HomeInitialState(
          breakingNewsPosts: breakingNewsPosts,
          recommendedgNewsPosts: recommendedgNewsPosts));
    }

    if (response is DataError) {
      emit(HomeErrosState(errorMessage: response.error));
    }
  }
}
