import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SelectedItemsLabel extends StatelessWidget {
  const SelectedItemsLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Ink(
              height: 40.0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: const BoxDecoration(
                color: AppColors.darkGreen,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Row(
                children: [
                  const ImageIcon(
                    AppIcons.list,
                    color: AppColors.white,
                  ),
                  Container(
                    constraints: const BoxConstraints(
                      minHeight: 22.0,
                      minWidth: 22.0,
                    ),
                    padding: const EdgeInsets.all(2.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                    child: Text(
                      '20',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: AppColors.darkGreen,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 24.0,
        ),
      ],
    );
  }
}
