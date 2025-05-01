import 'package:flutter/material.dart';

import '../../data/models/user.dart';
import '../../../shared/presentation/widgets/network_image.dart' as ni;
import '../../../shared/presentation/widgets/progress_indicator.dart';
import '../../../shared/presentation/extensions/open_in_app_browser.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () => openBrowser(url: user.profileUrl),
        borderRadius: BorderRadius.circular(10.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              ni.NetworkImage(
                configuration: ni.NetworkImageConfiguration(
                  url: user.avatarUrl,
                  height: 100.0,
                  width: 100.0,
                  progressIndicatorConfiguration:
                      const ProgressIndicatorConfiguration(
                    height: 30.0,
                    width: 30.0,
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Text(user.login),
            ],
          ),
        ),
      ),
    );
  }
}
