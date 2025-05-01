import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'app.dart';

import '../router/app_router.dart';

void main() {
  runApp(
    App(
      router: AppRouter(),
      connectivity: Connectivity(),
    ),
  );
}
