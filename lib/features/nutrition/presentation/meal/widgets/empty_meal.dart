import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

const _kHeightContainer = 212.0;

class EmptyMeal extends StatelessWidget {
  final String? message;

  const EmptyMeal({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kHeightContainer,
      color: AppColors.greenLightest,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppIcons.mealEmpty,
              const SizedBox(height: 16.0),
              CustomText.w400(
                message ?? LocalizedTexts.logListEmptyMessage.tr(),
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
