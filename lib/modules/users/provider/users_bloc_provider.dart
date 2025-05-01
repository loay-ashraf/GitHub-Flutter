import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../logic/blocs/users_bloc.dart';
import '../data/repositories/users_repository.dart';
import '../data/apis/users_api.dart';

class UsersBlocProvider extends BlocProvider<UsersBloc> {
  UsersBlocProvider({super.key, super.child})
      : super(
          create: (context) {
            final client = context.read<Dio>();
            final UsersApi api = UsersApiImpl(client: client);
            final UsersRepository repository = UsersRepositoryImpl(api: api);
            final UsersBloc bloc = UsersBloc(repository: repository);
            return bloc;
          },
        );
}
