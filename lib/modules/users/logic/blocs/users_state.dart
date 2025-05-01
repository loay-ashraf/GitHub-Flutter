import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/models/user.dart';

@immutable
abstract class UsersState extends Equatable {}

final class UsersStateInitial extends UsersState {
  final List<User> users = [];

  @override
  List<Object?> get props => [users];
}

final class UsersStateLoading extends UsersState {
  @override
  List<Object?> get props => [];
}

final class UsersStateReloading extends UsersState {
  UsersStateReloading({required this.existingUsers});

  final List<User> existingUsers;

  @override
  List<Object?> get props => [existingUsers];
}

final class UsersStateDataLoaded extends UsersState {
  UsersStateDataLoaded({required this.users});

  final List<User> users;

  @override
  List<Object?> get props => [users];
}

final class UsersStateError extends UsersState {
  UsersStateError({required this.message, this.detailsMessage});

  final String message;
  final String? detailsMessage;

  @override
  List<Object?> get props => [message, detailsMessage];
}

extension Users on UsersState {
  List<User> get availableUsers {
    if (this is UsersStateInitial) {
      return (this as UsersStateInitial).users;
    } else if (this is UsersStateDataLoaded) {
      return (this as UsersStateDataLoaded).users;
    } else if (this is UsersStateReloading) {
      return (this as UsersStateReloading).existingUsers;
    }
    return [];
  }
}
