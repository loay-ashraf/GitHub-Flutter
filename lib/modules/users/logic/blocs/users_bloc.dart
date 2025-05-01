import 'package:bloc/bloc.dart';

import 'users_event.dart';
import 'users_state.dart';
import '../../data/repositories/users_repository.dart';
import '../../../shared/data/models/network_exception.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc({required this.repository}) : super(UsersStateInitial()) {
    _setupEventHandlers();
  }

  final UsersRepository repository;

  void _setupEventHandlers() {
    on<UsersEventLoad>(_onLoad);
    on<UsersEventReload>(_onReload);
  }

  void _onLoad(
    UsersEventLoad event,
    Emitter<UsersState> emit,
  ) async {
    try {
      emit(UsersStateLoading());
      final users = await repository.fetchUsers();
      emit(UsersStateDataLoaded(users: users));
    } on NetworkException catch (networkException) {
      _onException(networkException, emit);
    }
  }

  void _onReload(
    UsersEventReload event,
    Emitter<UsersState> emit,
  ) async {
    try {
      emit(
        UsersStateReloading(
            existingUsers: (state as UsersStateDataLoaded).users),
      );
      final users = await repository.fetchUsers();
      emit(UsersStateDataLoaded(users: users));
    } on NetworkException catch (networkException) {
      _onException(networkException, emit);
    }
  }

  void _onException(
    NetworkException exception,
    Emitter<UsersState> emit,
  ) {
    emit(UsersStateError(
      message: 'Failed to (re)load users, please try again!',
      detailsMessage: exception.message,
    ));
  }
}
