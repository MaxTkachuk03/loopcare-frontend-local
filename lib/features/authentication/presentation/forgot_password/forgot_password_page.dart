import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email.dart';
import 'package:loopcare_frontend/features/authentication/presentation/forgot_password/widgets/forgot_password_form.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formValidationNotifier = ValueNotifier<bool>(false);
  String _email = '';

  @override
  void dispose() {
    _formValidationNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: CustomScaffold.blueLightest(
        key: const ValueKey('forgot_password_page'),
        appBar: CustomAppBar.blue(leading: CustomFilledIconButton.leadingBlueLighter()),
        body: CustomSafeArea(
          child: BottomPlacedButton.blueLightest(
            body: MainContainer(
              child: ListView(
                key: const ValueKey('forgot_password_page_body'),
                physics: const ClampingScrollPhysics(),
                children: [
                  const SizedBox(height: 50.0),
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
                  const SizedBox(height: 30.0),
                  ForgotPasswordForm(
                      key: const ValueKey('forgot_password_form'), onFormChanged: _onFormChanged),
                  const SizedBox(height: 28.0),
                ],
              ),
            ),
            button: ValueListenableBuilder<bool>(
              valueListenable: _formValidationNotifier,
              builder: (context, isValid, _) {
                return CustomElevatedButton.blueFullWidth(
                  key: const ValueKey('forgot_password_continue_button'),
                  onPressed: isValid ? _onContinuePressed : null,
                  label: LocalizedTexts.continueBtn.tr(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _onContinuePressed() =>
      context.read<AuthenticationBloc>().add(AuthenticationEvent.forgotPassword(_email));

  void _onFormChanged(String email) {
    _email = email;

    final isValidForm = Email.create(_email).isRight();
    _formValidationNotifier.value = isValidForm;
  }
}
