import '../apis/repositories_api.dart';
import '../models/repository.dart';
import 'package:github/modules/shared/data/models/search_result.dart';

abstract class RepositoriesRepository {
  Future<List<Repository>> fetchRepositories();
}

class RepositoriesRepositoryImpl extends RepositoriesRepository {
  RepositoriesRepositoryImpl({required this.api});

  final RepositoriesApi api;

  @override
  Future<List<Repository>> fetchRepositories() async {
    final dynamic searchResultJson = await api.fetchRepositories();
    final SearchResult searchResult = SearchResult.fromJson(searchResultJson);
    final List<dynamic> repositoriesJson = searchResult.items;
    final repositories =
        repositoriesJson.map((json) => Repository.fromJson(json)).toList();
    return repositories;
  }
}
