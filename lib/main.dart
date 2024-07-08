import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/post_bloc.dart';
import 'repositories/post_repository.dart';
import 'services/api_service.dart';
import 'view/home_page.dart';
import 'usecases/get_posts_usecase.dart';

void main() {
  final dio = Dio();
  final apiService = ApiService(dio: dio);
  final postRepository = PostRepositoryImpl(apiService: apiService);
  final getPostsUseCase = GetPostsUseCase(postRepository: postRepository);

  runApp(MyApp(getPostsUseCase: getPostsUseCase));
}

class MyApp extends StatelessWidget {
  final GetPostsUseCase getPostsUseCase;

  const MyApp({required this.getPostsUseCase, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => PostBloc(getPostsUseCase),
        child: const HomePage(),
      ),
    );
  }
}
