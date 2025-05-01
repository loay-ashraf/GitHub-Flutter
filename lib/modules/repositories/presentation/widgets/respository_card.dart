import 'package:flutter/material.dart';

import '../../data/models/repository.dart';
import '../../../shared/presentation/extensions/open_in_app_browser.dart';

class RepositoryCard extends StatelessWidget {
  const RepositoryCard({super.key, required this.repository});

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        title: Text(
          repository.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          repository.description,
          style: const TextStyle(
            color: Colors.blueGrey,
          ),
        ),
        onTap: () => openBrowser(url: repository.url),
      ),
    );
  }
}
