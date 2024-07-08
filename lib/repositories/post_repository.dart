import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../models/post.dart';
import '../services/api_service.dart';

abstract class PostRepository {
  Future<Either<ErrorModel, List<PostModel>>> getPosts();
}

class PostRepositoryImpl implements PostRepository {
  final ApiService apiService;

  PostRepositoryImpl({required this.apiService});

  @override
  Future<Either<ErrorModel, List<PostModel>>> getPosts() async {
    try {
      final response = await apiService.fetchPosts();
      if (response.statusCode == 200) {
        final posts = (response.data as List)
            .map((post) => PostModel.fromMap(post))
            .toList();
        return right(posts);
      } else {
        return left(
            ErrorModel(errorMessage: response.statusMessage ?? 'Unknown error'));
      }
    } on DioError catch (e) {
      return left(ErrorModel(errorMessage: e.message ?? 'Default error message'));
    }
  }
}
