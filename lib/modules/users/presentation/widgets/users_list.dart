import 'package:flutter/material.dart';

import 'user_card.dart';
import '../../data/models/user.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key, required this.users});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(25.0),
      itemCount: users.length,
      itemBuilder: (context, index) => UserCard(
        user: users[index],
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 15.0,
      ),
    );
  }
}
