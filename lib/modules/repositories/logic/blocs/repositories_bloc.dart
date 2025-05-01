import 'package:flutter_bloc/flutter_bloc.dart';

import 'repositories_event.dart';
import 'repositories_state.dart';
import '../../data/repositories/repositories_repository.dart';
import '../../../shared/data/models/network_exception.dart';

class RepositoriesBloc extends Bloc<RepositoriesEvent, RepositoriesState> {
  RepositoriesBloc({required this.repository})
      : super(RepositoriesStateInitial()) {
    _setupEventHandlers();
  }

  final RepositoriesRepository repository;

  void _setupEventHandlers() {
    on<RepositoriesEventLoad>(_onLoad);
    on<RepositoriesEventReload>(_onReload);
  }

  void _onLoad(
    RepositoriesEventLoad event,
    Emitter<RepositoriesState> emit,
  ) async {
    try {
      emit(RepositoriesStateLoading());
      // await Future.delayed(
      //   const Duration(
      //     seconds: 3,
      //   ),
      // );
      final users = await repository.fetchRepositories();
      emit(RepositoriesStateDataLoaded(users: users));
    } on NetworkException catch (networkException) {
      _onException(networkException, emit);
    }
  }

  void _onReload(
    RepositoriesEventReload event,
    Emitter<RepositoriesState> emit,
  ) async {
    try {
      emit(RepositoriesStateReloading(
          existingRepositories: (state as RepositoriesStateDataLoaded).users));
      // await Future.delayed(
      //   const Duration(
      //     seconds: 3,
      //   ),
      // );
      final users = await repository.fetchRepositories();
      emit(RepositoriesStateDataLoaded(users: users));
    } on NetworkException catch (networkException) {
      _onException(networkException, emit);
    }
  }

  void _onException(
    NetworkException exception,
    Emitter<RepositoriesState> emit,
  ) {
    emit(RepositoriesStateError(
      message: 'Failed to (re)load repositories, please try again!',
      detailsMessage: exception.message,
    ));
  }
}
