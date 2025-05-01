import 'package:flutter/material.dart';

import 'respository_card.dart';
import '../../data/models/repository.dart';

class RepositoriesList extends StatelessWidget {
  const RepositoriesList({super.key, required this.repositories});

  final List<Repository> repositories;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(25.0),
      itemCount: repositories.length,
      itemBuilder: (context, index) => RepositoryCard(
        repository: repositories[index],
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 15.0,
      ),
    );
  }
}
