import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  bool _isDisabled = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listenWhen: _redirectListenWhen,
      listener: _redirectListener,
      child: Form(
        key: _formKey,
        onChanged: _onChangedForm,
        child: Column(
          children: [
            CustomTextField.email(controller: _emailController),
            const SizedBox(height: 28.0),
            CustomElevatedButton.blueFullWidth(
              onPressed: _isDisabled ? null : () => _onContinuePressed(context),
              label: LocalizedTexts.continueBtn.tr(),
            ),
          ],
        ),
      ),
    );
  }

  void _onContinuePressed(BuildContext context) {
    context.read<AuthenticationCubit>().forgotPassword(_emailController.text);
  }

  void _onChangedForm() {
    final isValidForm = Email.create(_emailController.text).isRight();

    setState(() {
      _isDisabled = !isValidForm;
    });
  }

  void _redirectListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(guest: (state) {
      context.showSuccessBar(
        content: Text(
          LocalizedTexts.forgotEmailSuccessMessage.tr(
            namedArgs: {
              'email': state.maybeMap(guest: (s) => s.email ?? '', orElse: () => ''),
            },
          ),
        ),
        actions: [TextButton(onPressed: () => context.router.pop(), child: const Text('Ok'))],
      );

      context.router.pushNamed(AppRoutes.login);
    });
  }

  bool _redirectListenWhen(AuthenticationState previous, AuthenticationState current) {
    final previousEmail = previous.maybeMap(guest: (state) => state.emailWasSend, orElse: () => false);
    final currentEmail = current.maybeMap(guest: (state) => state.emailWasSend, orElse: () => false);
    final error = current.mapOrNull(guest: (state) => state.error);

    return previousEmail != currentEmail && currentEmail && error == null;
  }
}
