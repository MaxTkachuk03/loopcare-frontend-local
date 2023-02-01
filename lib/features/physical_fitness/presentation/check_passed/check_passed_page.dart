import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/small_filled_button.dart';
import 'package:loopcare_frontend/core/presentation/widgets/success_container.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/physical_question_wrap.dart';

class CheckPassedPage extends StatelessWidget {
  const CheckPassedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PhysicalFitnessBloc>().state;

    return PhysicalQuestionWrap(
      child: MainContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 86),
                SuccessContainer(
                  title: LocalizedTexts.fitnessCheckPassedTitle.tr(),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(LocalizedTexts.age.tr()),
                              Text(LocalizedTexts.height.tr()),
                              Text(LocalizedTexts.weight.tr()),
                              Text(LocalizedTexts.bmi.tr()),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${bloc.age} years',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                '${bloc.heightInCm} cm',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                '${bloc.weightInKg} kg',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                '${bloc.bmi}',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        LocalizedTexts.fitnessCheckPassedText.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: AppColors.blueDark),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SmallFilledButton(
                        text: LocalizedTexts.moreInfo.tr(),
                        onPressed: _onMoreInfoPressed,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () => _onContinuePressed(context),
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.orangeDark),
                      ),
                  child: Text(LocalizedTexts.continueBtn.tr()),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onContinuePressed(BuildContext context) {
    context
      ..read<OnboardingBloc>().add(const OnboardingEvent.nextStep())
      ..router.pushNamed(AppRoutes.medicalIntro);
  }

  void _onMoreInfoPressed() {}
}
