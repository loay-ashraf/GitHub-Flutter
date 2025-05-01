import 'package:meta/meta.dart';

import '../../data/models/user.dart';

@immutable
class UsersState {
  const UsersState({required this.isLoading, required this.users});

  final bool isLoading;
  final List<User> users;
}

final class UsersInitialState extends UsersState {
  UsersInitialState() : super(isLoading: false, users: []);
}
