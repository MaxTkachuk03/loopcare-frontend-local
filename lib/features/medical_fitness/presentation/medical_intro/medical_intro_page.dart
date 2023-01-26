import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/medical_intro/widgets/app_bar_sub_title.dart';
import 'package:loopcare_frontend/features/medical_fitness/presentation/medical_intro/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/progress_bar.dart';

class MedicalIntroPage extends StatelessWidget {
  const MedicalIntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text(LocalizedTexts.bodyAndMind.tr()),
              const AppBarSubTitle(),
            ],
          ),
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const ProgressBar(),
                      const SizedBox(
                        height: 80.0,
                      ),
                      Text(
                        LocalizedTexts.checkYourMedicalCondition.tr(),
                        style: Theme.of(context).textTheme.headline3?.copyWith(
                              fontFamily: ThemeConstants.bitterFontFamily,
                            ),
                      ),
                      const SizedBox(
                        height: 21.0,
                      ),
                      Text(
                        LocalizedTexts.medicalIntroTitle.tr(),
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      BulletListItem(
                        bulletSize: 18.0,
                        text: Text(
                          LocalizedTexts.medicalIntroInstructionFirst.tr(),
                          style: const TextStyle(
                            fontSize: ThemeConstants.fontSize18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      BulletListItem(
                        bulletSize: 18.0,
                        text: Text(
                          LocalizedTexts.medicalIntroInstructionSecond.tr(),
                          style: const TextStyle(
                            fontSize: ThemeConstants.fontSize18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      BulletListItem(
                        bulletSize: 18.0,
                        text: Text(
                          LocalizedTexts.medicalIntroInstructionThird.tr(),
                          style: const TextStyle(
                            fontSize: ThemeConstants.fontSize18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => _onNextPressed(context),
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style
                            ?.copyWith(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.orangeDark),
                            ),
                        child: Text(LocalizedTexts.next.tr()),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onNextPressed(BuildContext context) {
    context.router.pushNamed(AppRoutes.pregnancy);
  }

  Future<bool> _onWillPop(BuildContext context) {
    context.read<OnboardingBloc>().add(const OnboardingEvent.previousStep());

    return Future.value(true);
  }
}
