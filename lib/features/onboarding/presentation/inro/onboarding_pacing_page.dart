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
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';

@RoutePage()
class OnboardingPacingPage extends StatelessWidget {
  const OnboardingPacingPage({super.key});

  void _onNextPressed(BuildContext context) => context.router.pushNamed(AppRoutes.name);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blueLightest(
      appBar: CustomAppBar.transparent(leading: CustomFilledIconButton.leadingWhite()),
      body: CustomSafeArea(
        child: BottomPlacedButton.blueLightest(
          body: Column(
            children: [
              MainContainer(
                child: CustomText.bitter600(
                  LocalizedTexts.onboardingPacingTitle.tr(),
                  style: context.textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 80),
              const Image(image: AppImages.onboardingPacing),
              const Spacer(),
              MainContainer(
                child: CustomText.w600(
                  LocalizedTexts.onboardingPacingMessage.tr(),
                  style: context.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              const SizedBox(height: 30),
            ],
          ),
          button: CustomElevatedButton.blueFullWidth(
            label: LocalizedTexts.iAmReady.tr(),
            onPressed: () => _onNextPressed(context),
          ),
        ),
      ),
    );
  }
}
