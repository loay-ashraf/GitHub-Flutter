import '../apis/users_api.dart';
import '../models/user.dart';

abstract class UsersRepository {
  Future<List<User>> fetchUsers();
}

class UsersRepositoryImpl extends UsersRepository {
  UsersRepositoryImpl({required this.api});

  final UsersApi api;

  @override
  Future<List<User>> fetchUsers() async {
    final List<dynamic> usersJson = await api.fetchUsers();
    final users = usersJson.map((json) => User.fromJson(json)).toList();
    return users;
  }
}
