import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/medical_question_wrap.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/progress_bar.dart';

class MedicalCheckFailedPage extends StatelessWidget {
  const MedicalCheckFailedPage({super.key});

  void _onNextPressed(BuildContext context) {
    context.router.pushNamed(AppRoutes.medicalCheckPassed);
  }

  @override
  Widget build(BuildContext context) {
    return MedicalQuestionWrap(
      child: CustomScaffold.blue(
        appBar: CustomAppBar.blue(
          leading: CustomFilledIconButton.leadingBlueLighter(),
          title: LocalizedTexts.medicalIntroTitle.tr(),
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ProgressBar.coral(backgroundColor: AppColors.blueRegular),
                    UnderAppbar.blue(
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
                                style: context.textTheme.displayMedium?.copyWith(color: AppColors.white),
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
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: BlocBuilder<MedicalFitnessBloc, MedicalFitnessState>(
                          builder: (BuildContext context, state) {
                            return Column(
                              children: [
                                CustomText.w400(
                                  LocalizedTexts.medicalCheckFailedBody,
                                  style: context.textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 30.0),
                                Column(
                                  children: state.data.listDiseasesEnabled
                                      .map((e) => BulletListItem(
                                          text: CustomText.w600(
                                            e.diseases.label,
                                            style: context.textTheme.bodyMedium,
                                          ),
                                          bulletSize: 18))
                                      .toList(),
                                ),
                                const SizedBox(height: 30.0),
                                if (state.data.isTreatedByPsychologist)
                                  CustomText.w400(
                                    LocalizedTexts.medicalCheckFailedBody2,
                                    style: context.textTheme.bodyMedium,
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                  ],
                ),
                MainContainer(
                  child: Column(
                    children: [
                      CustomElevatedButton.coralFullWidth(
                        onPressed: () => _onNextPressed(context),
                        label: LocalizedTexts.next.tr(),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
