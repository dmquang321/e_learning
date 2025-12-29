import 'package:flutter/material.dart';
import 'package:e_learning/core/constants/app_constants.dart';

class ProgressBar extends StatelessWidget {
  final double progress;
  final double height;
  final Color? backgroundColor;
  final Color? progressColor;

  const ProgressBar({
    super.key,
    required this.progress,
    this.height = 8,
    this.backgroundColor,
    this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: height,
        backgroundColor: backgroundColor ?? Colors.grey[300],
        valueColor: AlwaysStoppedAnimation<Color>(
          progressColor ?? const Color(AppConstants.successColor),
        ),
      ),
    );
  }
}
