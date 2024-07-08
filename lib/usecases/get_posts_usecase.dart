import 'package:dartz/dartz.dart';

import '../models/post.dart';
import '../repositories/post_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call({Params params});
}

class GetPostsUseCase implements UseCase<Either<ErrorModel, List<PostEntity>>, void> {
  final PostRepository postRepository;

  GetPostsUseCase({required this.postRepository});

  @override
  Future<Either<ErrorModel, List<PostEntity>>> call({void params}) {
    return postRepository.getPosts();
  }
}
