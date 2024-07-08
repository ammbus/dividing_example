import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;
  final String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  ApiService({required this.dio});

  Future<Response> fetchPosts() async {
    return await dio.get(baseUrl);
  }
}
