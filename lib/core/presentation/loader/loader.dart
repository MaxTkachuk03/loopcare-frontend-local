import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader_item.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            top: size.height / 2 - 50,
            left: size.width / 2 - 25,
            child: const LoaderItem(
              endColor: AppColors.orange,
              delayBeforeStart: Duration(milliseconds: 0),
            ),
          ),
          Positioned(
            top: size.height / 2 - 35,
            left: size.width / 2 - 50,
            child: const LoaderItem(
              endColor: AppColors.blueMid,
              delayBeforeStart: Duration(milliseconds: 300),
            ),
          ),
          Positioned(
            left: size.width / 2 - 25,
            top: size.height / 2 - 20,
            child: const LoaderItem(
              endColor: AppColors.yellowish,
              delayBeforeStart: Duration(milliseconds: 600),
            ),
          ),
          Positioned(
            top: size.height / 2 - 35,
            left: size.width / 2 - 0,
            child: const LoaderItem(
              endColor: AppColors.greenLight,
              delayBeforeStart: Duration(milliseconds: 900),
            ),
          ),
        ],
      ),
    );
  }
}
