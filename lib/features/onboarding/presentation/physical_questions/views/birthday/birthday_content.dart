import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/physical_questions/views/birthday/widgets/birthday_field.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class BirthdayContent extends StatelessWidget {
  const BirthdayContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MainContainer(
          child: Column(
            children: [
              const SizedBox(height: 50.0),
              CustomText.bitter600(
                LocalizedTexts.yourBirthday.tr(),
                textAlign: TextAlign.center,
                style: context.textTheme.displayMedium,
              ),
            ],
          ),
        ),
        const BirthdayField(),
      ],
    );
  }
}
