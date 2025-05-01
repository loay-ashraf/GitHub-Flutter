import 'package:flutter/material.dart';

final class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({
    super.key,
    required this.configuration,
  });

  final ProgressIndicatorConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: configuration.height,
        width: configuration.width,
        child: CircularProgressIndicator(
          value: configuration.value,
          backgroundColor: configuration.backgroundColor,
          color: configuration.color,
        ),
      ),
    );
  }
}

class ProgressIndicatorConfiguration {
  const ProgressIndicatorConfiguration({
    this.value,
    this.height,
    this.width,
    this.backgroundColor,
    this.color,
  });

  final double? value;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? color;
}
