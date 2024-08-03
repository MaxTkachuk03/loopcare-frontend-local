import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
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
import 'package:loopcare_frontend/injection.dart';

@RoutePage()
class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  AppConfig get _appConfig => getIt<AppConfig>();

  void _onGetStarted(BuildContext context) {
    context.router.pushNamed(AppRoutes.onboardingIntro);
  }

  void _onLoginTap(BuildContext context) {
    context.router.pushNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blueLightest(
      key: const ValueKey('intro_page'),
      body: CustomSafeArea(
        child: BottomPlacedButton.blueLightest(
          body: MainContainer(
            child: ListView(
              physics: const ClampingScrollPhysics(),
              key: const ValueKey('intro_page_body'),
              children: [
                const SizedBox(height: 28.0),
                const Center(
                  child: Image(image: AppImages.intro),
                ),
                const SizedBox(height: 28.0),
                CustomText.bitter600(
                  '${LocalizedTexts.introTitle.tr(namedArgs: {
                        'projectName': _appConfig.projectName
                      })}!',
                  style: context.textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomText.w400(
                    '${LocalizedTexts.introBodyTextFirst.tr()}.',
                    style: context.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 57.0),
                  child: CustomText.w600(
                    '${LocalizedTexts.introBodyTextSecond.tr()}.',
                    style: context.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
          button: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomElevatedButton.blueFullWidth(
                key: const ValueKey('intro_lets_go_button'),
                label: LocalizedTexts.letsGo.tr(),
                onPressed: () => _onGetStarted(context),
              ),
              const SizedBox(height: 21.0),
              RichText(
                key: const ValueKey('intro_login_rich_text'),
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: context.textTheme.bodyMedium,
                  children: [
                    TextSpan(text: '${LocalizedTexts.haveAnAccount.tr()} '),
                    TextSpan(
                      text: LocalizedTexts.logIn.tr(),
                      style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      recognizer: TapGestureRecognizer()..onTap = () => _onLoginTap(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
