import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';

class PlusButtonHexagon extends StatelessWidget {
  const PlusButtonHexagon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Hexagon(
          width: 54,
          height: 54,
          borderRadius: 18,
          innerWidget: Container(
            color: AppColors.white,
            child: IconButton(
              icon: const ImageIcon(
                AppIcons.plus,
                color: AppColors.blueMid,
                size: 18,
              ),
              onPressed: () => context.router.pop(),
            ),
          ),
        )
      ],
    );
  }
}
