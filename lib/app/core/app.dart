import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../router/app_router.dart';
import '../provider/dio_provider.dart';

final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class App extends StatelessWidget {
  const App({
    super.key,
    required this.router,
    required this.connectivity,
  });

  final AppRouter router;
  final Connectivity connectivity;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      connectivity.onConnectivityChanged.skipWhile((results) {
        return [
          ConnectivityResult.wifi,
          ConnectivityResult.mobile,
          ConnectivityResult.ethernet
        ].contains(results.first);
      }).listen((results) {
        _connectivityListener(results);
      });
    });
    return MultiProvider(
      providers: [
        DioProvider(),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: _scaffoldMessengerKey,
        title: 'GitHub',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueGrey,
          ),
          useMaterial3: true,
        ),
        onGenerateRoute: router.onGenerateRoute,
      ),
    );
  }

  void _connectivityListener(List<ConnectivityResult> results) {
    final currentResult = results.last;
    String? connectionType;
    String message;

    switch (currentResult) {
      case ConnectivityResult.wifi:
        connectionType = 'wifi';
        break;
      case ConnectivityResult.mobile:
        connectionType = 'cellular';
        break;
      case ConnectivityResult.ethernet:
        connectionType = 'ethernet';
        break;
      default:
        break;
    }

    if (connectionType != null) {
      message = 'You are connected to the internet via $connectionType.';
    } else {
      message = 'You are disconnected from the internet.';
    }

    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
  }
}
