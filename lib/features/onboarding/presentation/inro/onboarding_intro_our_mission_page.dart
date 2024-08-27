import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/text_size_util.dart';
import 'package:loopcare_frontend/core/presentation/widgets/animated_fade_holder/animated_fade_holder.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

part 'widgets/_members.dart';
part 'widgets/_team_view.dart';

@RoutePage()
class OnboardingIntroOurMissionPage extends StatefulWidget {
  const OnboardingIntroOurMissionPage({super.key});

  @override
  State<OnboardingIntroOurMissionPage> createState() => _OnboardingIntroOurMissionPageState();
}

class _OnboardingIntroOurMissionPageState extends State<OnboardingIntroOurMissionPage> {
  final controller = PageController();
  final progressPageListener = ValueNotifier<double?>(null);

  void _onNextPressed() => context.router.pushNamed(AppRoutes.onboardingPacing);

  double get _textHeight => textHeight(
        _longestMemberDescription.tr(),
        MediaQuery.of(context).size.width - 80.0,
        context.textTheme.bodyMedium,
        MediaQuery.of(context).textScaler,
      );

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      progressPageListener.value = controller.page;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    progressPageListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blueLightest(
      appBar: CustomAppBar.transparent(leading: CustomFilledIconButton.leadingWhite()),
      body: CustomSafeArea(
        child: BottomPlacedButton.blueLightest(
          body: ListView(
            children: [
              MainContainer(
                child: CustomText.bitter600(
                  LocalizedTexts.onboardingIntroMissionTitle.tr(),
                  style: context.textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              _TeamView(
                controller: controller,
              ),
              SizedBox(
                height: _textHeight,
                child: PageView.builder(
                  controller: controller,
                  itemCount: _Member.values.length,
                  itemBuilder: (context, index) {
                    return ValueListenableBuilder<double?>(
                      valueListenable: progressPageListener,
                      builder: (context, value, child) {
                        final opacity = (1 - (index - (value ?? 0.0)).abs() * 4).clamp(0.0, 1.0);

                        return Opacity(
                          opacity: opacity,
                          child: child!,
                        );
                      },
                      child: MainContainer(
                        child: CustomText.w600(
                          _Member.values[index].description.tr(),
                          style: context.textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 5,
                  effect: const ColorTransitionEffect(
                    activeDotColor: AppColors.blueDarker,
                    dotColor: AppColors.blueLighter,
                    dotHeight: 12.0,
                    dotWidth: 12.0,
                  ),
                  onDotClicked: controller.jumpToPage,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          button: CustomElevatedButton.blueFullWidth(
            label: LocalizedTexts.next.tr(),
            onPressed: _onNextPressed,
          ),
        ),
      ),
    );
  }
}
