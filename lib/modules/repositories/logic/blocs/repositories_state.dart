import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/models/repository.dart';

@immutable
abstract class RepositoriesState extends Equatable {}

final class RepositoriesStateInitial extends RepositoriesState {
  final List<Repository> users = [];

  @override
  List<Object?> get props => [users];
}

final class RepositoriesStateLoading extends RepositoriesState {
  @override
  List<Object?> get props => [];
}

final class RepositoriesStateReloading extends RepositoriesState {
  RepositoriesStateReloading({required this.existingRepositories});

  final List<Repository> existingRepositories;

  @override
  List<Object?> get props => [existingRepositories];
}

final class RepositoriesStateDataLoaded extends RepositoriesState {
  RepositoriesStateDataLoaded({required this.users});

  final List<Repository> users;

  @override
  List<Object?> get props => [users];
}

final class RepositoriesStateError extends RepositoriesState {
  RepositoriesStateError({required this.message, this.detailsMessage});

  final String message;
  final String? detailsMessage;

  @override
  List<Object?> get props => [message, detailsMessage];
}

extension Repositories on RepositoriesState {
  List<Repository> get availableRepositories {
    if (this is RepositoriesStateInitial) {
      return (this as RepositoriesStateInitial).users;
    } else if (this is RepositoriesStateDataLoaded) {
      return (this as RepositoriesStateDataLoaded).users;
    } else if (this is RepositoriesStateReloading) {
      return (this as RepositoriesStateReloading).existingRepositories;
    }
    return [];
  }
}
