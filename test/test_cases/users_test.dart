import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/users_repository_mock.dart';
import 'package:github/modules/users/logic/blocs/users_bloc.dart';
import 'package:github/modules/users/logic/blocs/users_event.dart';
import 'package:github/modules/users/logic/blocs/users_state.dart';
import 'package:github/modules/users/data/models/user.dart';
import 'package:github/modules/shared/data/models/network_exception.dart';

void main() {
  late UsersRepositoryMock usersRepositoryMock;
  late List<User> usersStub;
  late NetworkException exceptionStub;
  late UsersBloc usersBloc;

  List<User> parseUsersStub() {
    final bodyStub =
        File('test/stubs/users_response_stub.json').readAsStringSync();
    final List<dynamic> userList = jsonDecode(bodyStub);
    final List<User> users =
        userList.map((json) => User.fromJson(json)).toList();
    return users;
  }

  setUp(() {
    usersStub = parseUsersStub();
    exceptionStub = NetworkException(
      originalException: DioException(
          requestOptions: RequestOptions(), message: 'Bad status code: 404'),
    );
    usersRepositoryMock = UsersRepositoryMock();
    usersBloc = UsersBloc(repository: usersRepositoryMock);
  });

  tearDown(() {
    usersBloc.close();
  });

  blocTest<UsersBloc, UsersState>(
    'the bloc\'s initial state should be UsersStateInitial()',
    build: () => usersBloc,
    verify: (bloc) {
      expect(bloc.state, equals(UsersStateInitial()));
    },
  );

  blocTest<UsersBloc, UsersState>(
    'the bloc should emit a [UsersStateLoading(), UsersStateDataLoaded(users: usersStub)] when UsersEventLoad() is added and fetching is successful.',
    build: () => usersBloc,
    setUp: () => when(() => usersRepositoryMock.fetchUsers())
        .thenAnswer((_) async => usersStub),
    act: (bloc) => bloc.add(UsersEventLoad()),
    expect: () => [
      UsersStateLoading(),
      UsersStateDataLoaded(
        users: usersStub,
      ),
    ],
  );

  blocTest<UsersBloc, UsersState>(
    'the bloc should emit a [UsersStateReloading(existingUsers: usersStub), UsersStateDataLoaded(users: usersStub)] when UsersEventReload() is added and fetching is successful.',
    build: () => usersBloc,
    setUp: () => when(() => usersRepositoryMock.fetchUsers())
        .thenAnswer((_) async => usersStub),
    seed: () => UsersStateDataLoaded(users: usersStub),
    act: (bloc) => bloc.add(UsersEventReload()),
    expect: () => [
      UsersStateReloading(
        existingUsers: usersStub,
      ),
      UsersStateDataLoaded(
        users: usersStub,
      ),
    ],
  );

  blocTest<UsersBloc, UsersState>(
    'the bloc should emit a [UsersStateLoading(), UsersStateError(message: \'Failed to (re)load users, please try again!\')] when UsersEventLoad() is added and fetching fails.',
    build: () => usersBloc,
    setUp: () =>
        when(() => usersRepositoryMock.fetchUsers()).thenThrow(exceptionStub),
    act: (bloc) => bloc.add(UsersEventLoad()),
    expect: () => [
      UsersStateLoading(),
      UsersStateError(
        message: 'Failed to (re)load users, please try again!',
        detailsMessage: 'Bad status code: 404',
      ),
    ],
  );

  blocTest<UsersBloc, UsersState>(
    'the bloc should emit a [UsersStateReloading(existingUsers: usersStub), UsersStateError(message: \'Failed to (re)load users, please try again!\')] when UsersEventReload() is added and fetching fails.',
    build: () => usersBloc,
    setUp: () =>
        when(() => usersRepositoryMock.fetchUsers()).thenThrow(exceptionStub),
    seed: () => UsersStateDataLoaded(users: usersStub),
    act: (bloc) => bloc.add(UsersEventReload()),
    expect: () => [
      UsersStateReloading(
        existingUsers: usersStub,
      ),
      UsersStateError(
        message: 'Failed to (re)load users, please try again!',
        detailsMessage: 'Bad status code: 404',
      ),
    ],
  );
}
