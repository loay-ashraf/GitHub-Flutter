import 'package:dio/dio.dart';

abstract class UsersApi {
  Future<dynamic> fetchUsers();
}

class UsersApiImpl extends UsersApi {
  UsersApiImpl({required this.client});

  final Dio client;

  @override
  Future<dynamic> fetchUsers() async {
    final response = await client.get('/users');
    return response.data;
  }
}
