import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formValidationNotifier = ValueNotifier<bool>(false);
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _formValidationNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: _redirectListenWhen,
      listener: _redirectListener,
      child: Form(
        key: _formKey,
        onChanged: _onChangedForm,
        child: Column(
          children: [
            CustomTextField.email(
              key: const ValueKey('forgot_password_email_text_field'),
              controller: _emailController,
            ),
            const SizedBox(height: 28.0),
            ValueListenableBuilder<bool>(
              valueListenable: _formValidationNotifier,
              builder: (context, isValid, _) {
                return CustomElevatedButton.blueFullWidth(
                  key: const ValueKey('forgot_password_continue_button'),
                  onPressed: isValid ? _onContinuePressed : null,
                  label: LocalizedTexts.continueBtn.tr(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onContinuePressed() => context.read<AuthenticationBloc>()
          .add(AuthenticationEvent.forgotPassword(_emailController.text));

  void _onChangedForm() {
    final isValidForm = Email.create(_emailController.text).isRight();
    _formValidationNotifier.value = isValidForm;
  }

  void _redirectListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(guest: (state) {
      context.showSuccessBar(
        content: Text(
          LocalizedTexts.forgotEmailSuccessMessage.tr(
            namedArgs: {
              'email': state.maybeWhen(
                guest: (data) => data.email,
                orElse: () => '',
              ),
            },
          ),
        ),
        actions: [TextButton(onPressed: () => context.router.pop(), child: const Text('Ok'))],
      );

      context.router.pushNamed(AppRoutes.login);
    });
  }

  bool _redirectListenWhen(AuthenticationState previous, AuthenticationState current) {
    final previousEmail = previous.maybeMap(guest: (state) => state.data.emailWasSend, orElse: () => false);
    final currentEmail = current.maybeMap(guest: (state) => state.data.emailWasSend, orElse: () => false);
    final error = current.mapOrNull(guest: (state) => state.data.error);

    return previousEmail != currentEmail && currentEmail && error == null;
  }
}
