import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

const double _defaultSize = 50;

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> _colorTween;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _colorTween = controller
        .drive(ColorTween(begin: AppColors.blueRegular.withOpacity(0.1), end: AppColors.blueRegular));

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: _defaultSize,
        width: _defaultSize,
        child: CircularProgressIndicator(
          valueColor: _colorTween,
          strokeWidth: 10,
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }
}
