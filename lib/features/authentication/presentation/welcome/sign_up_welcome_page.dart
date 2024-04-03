import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';

class SignUpWelcomePage extends StatelessWidget {
  const SignUpWelcomePage({super.key});

  void _onNextPressed(BuildContext context) => context.router.pushNamed(AppRoutes.password);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.green(
      key: const ValueKey('sign_up_welcome_page'),
      appBar: CustomAppBar.transparent(leading: const SizedBox.shrink()),
      body: CustomSafeArea(
        child: BottomPlacedButton.green(
          body: MainContainer(
            child: ListView(
              key: const ValueKey('sign_up_welcome_page_body'),
              physics: const ClampingScrollPhysics(),
              children: [
                const Center(
                  child: Image(image: AppImages.welcome),
                ),
                const SizedBox(height: 30.0),
                CustomText.bitter600(
                  '${LocalizedTexts.signUpWelcomeTitle.tr()}!',
                  style: context.textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: CustomText.w400(
                    '${LocalizedTexts.signUpWelcomeBody.tr()}.',
                    style: context.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
          button: CustomElevatedButton.blueFullWidth(
            key: const ValueKey('lets_go_button'),
            label: LocalizedTexts.letsGo.tr(),
            onPressed: () => _onNextPressed(context),
          ),
        ),
      ),
    );
  }
}
