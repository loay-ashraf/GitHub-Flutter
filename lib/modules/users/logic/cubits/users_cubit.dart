import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'users_state.dart';
import '../../data/models/user.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitialState());

  void fetchUsers() async {
    emit(const UsersState(isLoading: true, users: []));
    try {
      final dio = Dio();
      final response = await dio.getUri(
        Uri.parse('https://api.github.com/users'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> usersBody = response.data;
        final List<User> users =
            usersBody.map((json) => User.fromJson(json)).toList();

        emit(UsersState(isLoading: false, users: users));
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
