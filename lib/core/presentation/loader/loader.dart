import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader_item.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class Loader extends StatelessWidget {
  final double _loaderHeight = 56.0;

  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: SizedBox(
        height: _loaderHeight,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              top: 0,
              left: size.width / 2 - 25,
              child: const LoaderItem(
                endColor: AppColors.orange,
                delayBeforeStart: Duration(milliseconds: 0),
              ),
            ),
            Positioned(
              top: 15,
              left: size.width / 2 - 50,
              child: const LoaderItem(
                endColor: AppColors.blueMid,
                delayBeforeStart: Duration(milliseconds: 300),
              ),
            ),
            Positioned(
              left: size.width / 2 - 25,
              top: 30,
              child: const LoaderItem(
                endColor: AppColors.yellowish,
                delayBeforeStart: Duration(milliseconds: 600),
              ),
            ),
            Positioned(
              top: 15,
              left: size.width / 2 - 0,
              child: const LoaderItem(
                endColor: AppColors.greenLight,
                delayBeforeStart: Duration(milliseconds: 900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
