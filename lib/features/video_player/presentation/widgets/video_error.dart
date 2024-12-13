import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class VideoError extends StatelessWidget {
  final String? errorMessage;
  final double width;
  final double height;

  const VideoError({super.key, this.errorMessage, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Text(
          errorMessage ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14.0, color: AppColors.white),
        ),
      ),
    );
  }
}
