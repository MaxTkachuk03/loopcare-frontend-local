import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding/application/physical_questions/physical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/physical_questions/views/failed_bmi/widgets/failed_bmi_body.dart';
import 'package:loopcare_frontend/features/onboarding/utils/bmi_calculator.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class FailedBmiContent extends StatelessWidget {
  const FailedBmiContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        UnderAppbar.yellow(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 65.0),
              child: CustomText.bitter600(
                LocalizedTexts.onboardingAgeCheckFailedTitle.tr(),
                style: context.textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        const SizedBox(height: 48),
        MainContainer(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: const BoxDecoration(
              color: AppColors.yellowLightest,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: BlocBuilder<PhysicalQuestionsBloc, PhysicalQuestionsState>(
              builder: (context, state) {
                final bmiIndex = BmiCalculator.getUserBmiIndex(state.heightInCm, state.weightInKg);

                return FailedBmiBody(
                  key: const ValueKey('failed_bmi_body'),
                  bmi: bmiIndex,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
