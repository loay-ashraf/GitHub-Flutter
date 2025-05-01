import 'package:dio/dio.dart';

abstract class RepositoriesApi {
  Future<dynamic> fetchRepositories();
}

class RepositoriesApiImpl extends RepositoriesApi {
  RepositoriesApiImpl({required this.client});

  final Dio client;

  @override
  Future<dynamic> fetchRepositories() async {
    final response = await client.get('/search/repositories', queryParameters: {
      'q': 'flutter',
      'sort': 'stars',
      'order': 'desc',
      'per_page': 10,
    });
    return response.data;
  }
}
