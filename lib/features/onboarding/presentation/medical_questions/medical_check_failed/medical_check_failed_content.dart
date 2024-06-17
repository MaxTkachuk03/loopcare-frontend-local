import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/medical_questions/medical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/domain/diseases.dart';

class MedicalCheckFailedContent extends StatelessWidget {
  const MedicalCheckFailedContent({super.key});

  void _onNextPressed(BuildContext context) {
    context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.nextStep());
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<MedicalQuestionsBloc>().state;

    return BottomPlacedButton.coral(
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          UnderAppbar.coral(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 22.0,
                      backgroundColor: AppColors.white,
                      child: Icon(Icons.priority_high, size: 24, color: AppColors.blueDarker),
                    ),
                    const SizedBox(height: 22.0),
                    CustomText.bitter600(
                      '${LocalizedTexts.medicalCheckFailedTitle.tr()}!',
                      style: context.textTheme.displayMedium?.copyWith(color: AppColors.blueDarker),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 50.0),
          MainContainer(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: const BoxDecoration(
                color: AppColors.coralLightest,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Column(
                children: [
                  CustomText.w400(
                    LocalizedTexts.medicalCheckFailedBody.tr(),
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 30.0),
                  Column(
                    children: state.listDiseasesEnabled
                        .map((e) => BulletListItem(
                              text: CustomText.w600(
                                e.label.tr(),
                                style: context.textTheme.bodyMedium,
                              ),
                              bulletSize: 18,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 30.0),
                  if (state.treatmentByTheDoctor ?? false)
                    CustomText.w400(
                      LocalizedTexts.medicalCheckFailedBody2.tr(),
                      style: context.textTheme.bodyMedium,
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      button: CustomElevatedButton.blueFullWidth(
        onPressed: () => _onNextPressed(context),
        label: LocalizedTexts.next.tr(),
      ),
    );
  }
}
