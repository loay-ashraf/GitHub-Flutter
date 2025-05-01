import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/users_list.dart';
import '../../logic/blocs/users_bloc.dart';
import '../../logic/blocs/users_event.dart';
import '../../logic/blocs/users_state.dart';

import '../../../shared/presentation/extensions/show_error_dialog.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bloc = BlocProvider.of<UsersBloc>(context);
      bloc.add(UsersEventLoad());
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        title: const Text(
          'Users',
        ),
      ),
      body: BlocConsumer<UsersBloc, UsersState>(
        listenWhen: _usersBlocListenWhen,
        listener: _usersBlocListener,
        builder: _usersBlocBuilder,
      ),
    );
  }

  bool _usersBlocListenWhen(UsersState previous, UsersState current) {
    return current is UsersStateError;
  }

  void _usersBlocListener(BuildContext context, UsersState state) {
    final errorState = state as UsersStateError;

    showErrorDialog(
      context: context,
      message: errorState.message,
      detailsMessage: errorState.detailsMessage,
      primaryTitle: 'Retry',
      secondaryTitle: 'Go back',
      onPrimary: () => BlocProvider.of<UsersBloc>(context).add(
        UsersEventLoad(),
      ),
      onSecondary: () => Navigator.of(context).pop(),
    );
  }

  Widget _usersBlocBuilder(BuildContext context, UsersState state) {
    if (state is UsersStateLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          final completer = Completer<void>();
          final bloc = BlocProvider.of<UsersBloc>(context);
          final subscription = bloc.stream.listen((newState) {
            if (newState is! UsersStateReloading &&
                newState is UsersStateDataLoaded) {
              completer.complete();
            }
          });
          bloc.add(UsersEventReload());
          await completer.future;
          subscription.cancel();
        },
        child: UsersList(
          users: state.availableUsers,
        ),
      );
    }
  }
}
