import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
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
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

@RoutePage()
class OnboardingIntroPage extends StatelessWidget {
  const OnboardingIntroPage({super.key});

  void _onNextPressed(BuildContext context) => context.router.pushNamed(AppRoutes.onboardingIntroMission);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blueLightest(
      appBar: CustomAppBar.transparent(leading: CustomFilledIconButton.leadingWhite()),
      body: CustomSafeArea(
        child: BottomPlacedButton.blueLightest(
          body: ScrollableContainer(
            child: MainContainer(
              child: Column(
                children: [
                  CustomText.bitter600(
                    LocalizedTexts.onboardingIntroTitle.tr(),
                    style: context.textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Image(image: AppImages.onboardingIntroPrograms),
                  const SizedBox(height: 10),
                  CustomText.w600(
                    LocalizedTexts.onboardingIntroProgram1.tr(),
                    style: context.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  CustomText.w400(
                    LocalizedTexts.onboardingIntroProgram2.tr(),
                    style: context.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          button: CustomElevatedButton.blueFullWidth(
            label: LocalizedTexts.start.tr(),
            onPressed: () => _onNextPressed(context),
          ),
        ),
      ),
    );
  }
}
