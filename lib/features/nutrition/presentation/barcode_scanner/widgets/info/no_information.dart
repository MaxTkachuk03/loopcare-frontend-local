import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';

class NoInformation extends StatelessWidget {
  const NoInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(),
              ),
              IconButton(
                onPressed: () => {
                  context.router.pop(),
                },
                icon: const Icon(Icons.close),
              )
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(children: <Widget>[
            Hexagon(
              width: 80,
              height: 80,
              borderRadius: 15.0,
              innerWidget: Container(
                decoration: const BoxDecoration(
                  color: AppColors.orangeDark,
                  image: DecorationImage(
                    image: AppImages.questionMark,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              textAlign: TextAlign.center,
              LocalizedTexts.sorryNotFound.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.orangeDark,
                  ),
            ),
          ]),
        ),
        const SizedBox(height: 14),
        OutlinedButton(
          style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                side: MaterialStateProperty.all(
                    const BorderSide(width: 1.0, color: AppColors.black)),
              ),
          onPressed: () => context.router.pop(),
          child: Text(LocalizedTexts.scanOtherProduct.tr()),
        ),
      ],
    );
  }
}
