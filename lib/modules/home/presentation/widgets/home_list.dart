import 'package:flutter/material.dart';

import 'home_card.dart';
import 'package:github/app/router/app_routes.dart';

class HomeList extends StatelessWidget {
  const HomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 25.0,
      ),
      itemCount: 2,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return HomeCard(
              title: 'Users',
              icon: Icons.person,
              action: _navigateToUsers,
            );
          case 1:
            return HomeCard(
              title: 'Repositories',
              icon: Icons.data_object,
              action: _navigateToRepositories,
            );
          default:
            return null;
        }
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 15.0,
        );
      },
    );
  }

  void _navigateToUsers({required BuildContext context}) {
    Navigator.of(context).pushNamed(AppRoutes.users);
  }

  void _navigateToRepositories({required BuildContext context}) {
    Navigator.of(context).pushNamed(AppRoutes.repositories);
  }
}
