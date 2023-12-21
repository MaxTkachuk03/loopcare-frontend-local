import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/presentation/forgot_password/widgets%20/forgot_password_form.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.greenLightest(
      appBar: CustomAppBar.green(leading: CustomFilledIconButton.leadingGreenLighter()),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 54.0),
                const CircleAvatar(
                  radius: 28.0,
                  backgroundColor: AppColors.greenLight,
                  child: Icon(Icons.lock, size: 34),
                ),
                const SizedBox(height: 36.0),
                CustomText.bitter600(
                  '${LocalizedTexts.forgotPasswordTitle.tr()}?',
                  textAlign: TextAlign.center,
                  style: context.textTheme.displayMedium,
                ),
                const SizedBox(height: 20.0),
                CustomText.bitter600(
                  LocalizedTexts.forgotPasswordSubTitle.tr(),
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyLarge,
                ),
                const SizedBox(height: 20.0),
                CustomText.w400(
                  '${LocalizedTexts.forgotPasswordBody.tr()}.',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium,
                ),
                const SizedBox(height: 44.0),
                const ForgotPasswordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
