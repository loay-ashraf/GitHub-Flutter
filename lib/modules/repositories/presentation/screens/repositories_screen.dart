import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/repositories_list.dart';
import '../../logic/blocs/repositories_bloc.dart';
import '../../logic/blocs/repositories_event.dart';
import '../../logic/blocs/repositories_state.dart';

import '../../../shared/presentation/extensions/show_error_dialog.dart';

class RepositoriesScreen extends StatelessWidget {
  const RepositoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bloc = BlocProvider.of<RepositoriesBloc>(context);
      bloc.add(RepositoriesEventLoad());
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        title: const Text(
          'Repositories',
        ),
      ),
      body: BlocConsumer<RepositoriesBloc, RepositoriesState>(
        listenWhen: _repositoriesBlocListenWhen,
        listener: _repositoriesBlocListener,
        builder: _repositoriesBlocBuilder,
      ),
    );
  }

  bool _repositoriesBlocListenWhen(
      RepositoriesState previous, RepositoriesState current) {
    return current is RepositoriesStateError;
  }

  void _repositoriesBlocListener(
      BuildContext context, RepositoriesState state) {
    final errorState = state as RepositoriesStateError;

    showErrorDialog(
      context: context,
      message: errorState.message,
      detailsMessage: errorState.detailsMessage,
      primaryTitle: 'Retry',
      secondaryTitle: 'Go back',
      onPrimary: () => BlocProvider.of<RepositoriesBloc>(context).add(
        RepositoriesEventLoad(),
      ),
      onSecondary: () => Navigator.of(context).pop(),
    );
  }

  Widget _repositoriesBlocBuilder(
      BuildContext context, RepositoriesState state) {
    if (state is RepositoriesStateLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          final completer = Completer<void>();
          final bloc = BlocProvider.of<RepositoriesBloc>(context);
          final subscription = bloc.stream.listen((newState) {
            if (newState is! RepositoriesStateReloading &&
                newState is RepositoriesStateDataLoaded) {
              completer.complete();
            }
          });
          bloc.add(RepositoriesEventReload());
          await completer.future;
          subscription.cancel();
        },
        child: RepositoriesList(
          repositories: state.availableRepositories,
        ),
      );
    }
  }
}
