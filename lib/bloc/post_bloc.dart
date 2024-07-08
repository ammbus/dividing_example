import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import '../models/post.dart';
import '../usecases/get_posts_usecase.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostSuccess extends PostState {
  final List<PostEntity> posts;

  PostSuccess({required this.posts});
}

class PostError extends PostState {
  final String errorMessage;

  PostError({required this.errorMessage});
}

abstract class PostEvent {}

class GetPosts extends PostEvent {}

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostsUseCase getPostsUseCase;

  PostBloc(this.getPostsUseCase) : super(PostInitial()) {
    on<GetPosts>(
      (event, emit) async {
        emit(PostLoading());
        final result = await getPostsUseCase();

        result.fold(
          (error) => emit(PostError(errorMessage: error.errorMessage)),
          (posts) => emit(PostSuccess(posts: posts)),
        );
      },
    );
  }
}
