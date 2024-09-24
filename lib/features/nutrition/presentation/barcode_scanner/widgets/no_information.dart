import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class NoInformation extends StatelessWidget {
  const NoInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              IconButton(
                onPressed: context.router.maybePop,
                icon: const Icon(Icons.close),
              )
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            children: <Widget>[
              AppIcons.infoQuestion,
              const SizedBox(height: 8),
              CustomText.bitter600(
                textAlign: TextAlign.center,
                LocalizedTexts.sorryNotFound.tr(),
                style: context.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        CustomOutlinedButton.blueFullWidth(
          onPressed: context.router.maybePop,
          label: LocalizedTexts.scanOtherProduct.tr(),
        ),
      ],
    );
  }
}
