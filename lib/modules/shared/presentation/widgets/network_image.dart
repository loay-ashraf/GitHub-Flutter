import 'package:flutter/material.dart';

import 'progress_indicator.dart' as pi;

class NetworkImage extends StatelessWidget {
  const NetworkImage({
    super.key,
    required this.configuration,
  });

  final NetworkImageConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: configuration.height,
      width: configuration.width,
      child: ClipOval(
        child: Image.network(
          configuration.url,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return pi.ProgressIndicator(
                configuration: configuration.progressIndicatorConfiguration,
              );
            }
          },
        ),
      ),
    );
  }
}

class NetworkImageConfiguration {
  const NetworkImageConfiguration({
    required this.url,
    this.height,
    this.width,
    required this.progressIndicatorConfiguration,
  });

  final String url;
  final double? height;
  final double? width;
  final pi.ProgressIndicatorConfiguration progressIndicatorConfiguration;
}
