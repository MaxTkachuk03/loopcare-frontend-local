import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key, required this.onFormChanged});

  final void Function(String value) onFormChanged;

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
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
        child: CustomTextField.email(
          key: const ValueKey('forgot_password_email_text_field'),
          controller: _emailController,
        ),
      ),
    );
  }

  void _onChangedForm() => widget.onFormChanged(_emailController.text);

  void _redirectListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(
      guest: (state) {
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
          actions: [
            TextButton(
              onPressed: context.router.maybePop,
              child: const Text('Ok'),
            ),
          ],
        );

        context.router.pushNamed(AppRoutes.login);
      },
    );
  }

  bool _redirectListenWhen(AuthenticationState previous, AuthenticationState current) {
    final previousEmail = previous.maybeMap(guest: (state) => state.data.emailWasSend, orElse: () => false);
    final currentEmail = current.maybeMap(guest: (state) => state.data.emailWasSend, orElse: () => false);
    final error = current.mapOrNull(guest: (state) => state.data.error);

    return previousEmail != currentEmail && currentEmail && error == null;
  }
}
