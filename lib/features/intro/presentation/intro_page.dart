import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/injection.dart';

AppConfig appConfig = getIt<AppConfig>();

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  void _onGetStarted(BuildContext context) {
    context.router.pushNamed(AppRoutes.joinUs);
  }

  void _onLoginTap(BuildContext context) {
    context.router.pushNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.green(
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
                    Container(alignment: Alignment.center, child: const Image(image: AppImages.intro)),
                    const SizedBox(height: 28.0),
                    CustomText.bitter600(
                      '${LocalizedTexts.introTitle.tr(namedArgs: {'projectName': appConfig.projectName})}!',
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
                    const SizedBox(height: 36.0),
                  ],
                ),
                Column(
                  children: [
                    CustomElevatedButton.blueFullWidth(
                      label: LocalizedTexts.letsGo,
                      onPressed: () => _onGetStarted(context),
                    ),
                    const SizedBox(height: 21.0),
                    RichText(
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
                    const SizedBox(height: 30.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
