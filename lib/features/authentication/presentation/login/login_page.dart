import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/presentation/login/widgets/login_form.dart';
import 'package:loopcare_frontend/injection.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _onForgotMyPassword(BuildContext context) =>
      context.router.pushNamed(AppRoutes.forgotPassword);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.green(
      key: const ValueKey('login_page'),
      appBar: CustomAppBar.transparent(
        leading: context.router.canPop()
            ? CustomFilledIconButton.leadingGreenLighter()
            : const SizedBox.shrink(),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              key: const ValueKey('login_page_body'),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8.0),
                Container(alignment: Alignment.center, child: const Image(image: AppImages.intro)),
                const SizedBox(height: 24.0),
                CustomText.bitter600(
                  '${LocalizedTexts.loginTitle.tr(namedArgs: {'projectName': getIt<AppConfig>().projectName})}!',
                  style: context.textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 38.0),
                const LoginForm(
                  key: ValueKey('login_form'),
                ),
                TextButton(
                  key: const ValueKey('login_page_forgot_email_button'),
                  onPressed: () => _onForgotMyPassword(context),
                  child: CustomText.w700(
                    '${LocalizedTexts.forgotPassword.tr()}?',
                    style: context.textTheme.bodySmall?.copyWith(
                      decoration: TextDecoration.underline,
                      decorationThickness: 3.0,
                    ),
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
