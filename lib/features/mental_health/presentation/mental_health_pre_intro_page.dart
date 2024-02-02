import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';

class MentalHealthPreIntroPage extends StatefulWidget {
  const MentalHealthPreIntroPage({super.key});

  @override
  State<MentalHealthPreIntroPage> createState() => _MentalHealthPreIntroPageState();
}

class _MentalHealthPreIntroPageState extends State<MentalHealthPreIntroPage> {
  Future<bool> _onWillPop(BuildContext context) {
    context.read<OnboardingBloc>().add(const OnboardingEvent.previousStep());

    return Future.value(true);
  }

  void _onPressedHandler(BuildContext context) => context.router.pushNamed(AppRoutes.mentalHealthIntro);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: CustomScaffold.orange(
        appBar: CustomAppBar.transparent(leading: CustomFilledIconButton.leadingOrangeLighter()),
        body: SafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 8.0),
                      Container(
                          alignment: Alignment.center, child: const Image(image: AppImages.mentalIntro)),
                    ],
                  ),
                  Column(
                    children: [
                      CustomText.bitter600(
                        LocalizedTexts.mentalHealth.tr(),
                        style: context.textTheme.displayLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.watch_later_outlined),
                          const SizedBox(width: 10),
                          CustomText.w600(
                            '15 ${LocalizedTexts.minutes.tr()}',
                            style: context.textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      CustomText.w400(
                        '${LocalizedTexts.mentalIntroBody1.tr()}.',
                        style: context.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20.0),
                      CustomText.w400(
                        '${LocalizedTexts.mentalIntroBody2.tr()}.',
                        style: context.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20.0),
                      Builder(
                        builder: (context) => CustomElevatedButton.blueFullWidth(
                          label: LocalizedTexts.next.tr(),
                          onPressed: () => _onPressedHandler(context),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
