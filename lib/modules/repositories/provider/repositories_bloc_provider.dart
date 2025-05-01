import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../logic/blocs/repositories_bloc.dart';
import '../data/repositories/repositories_repository.dart';
import '../data/apis/repositories_api.dart';

class RepositoriesBlocProvider extends BlocProvider<RepositoriesBloc> {
  RepositoriesBlocProvider({super.key, super.child})
      : super(
          create: (context) {
            final client = context.read<Dio>();
            final RepositoriesApi api = RepositoriesApiImpl(client: client);
            final RepositoriesRepository repository =
                RepositoriesRepositoryImpl(api: api);
            final RepositoriesBloc bloc =
                RepositoriesBloc(repository: repository);
            return bloc;
          },
        );
}
