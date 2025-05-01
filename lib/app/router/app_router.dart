import 'package:flutter/material.dart';

import '../../modules/home/presentation/screens/home_screen.dart';
import '../../modules/users/presentation/screens/users_screen.dart';
import '../../modules/repositories/presentation/screens/repositories_screen.dart';

import '../../modules/users/provider/users_bloc_provider.dart';

import '../../modules/repositories/provider/repositories_bloc_provider.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case '/users':
        return MaterialPageRoute(
          builder: (_) => UsersBlocProvider(
            child: const UsersScreen(),
          ),
        );
      case '/repositories':
        return MaterialPageRoute(
          builder: (_) => RepositoriesBlocProvider(
            child: const RepositoriesScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
