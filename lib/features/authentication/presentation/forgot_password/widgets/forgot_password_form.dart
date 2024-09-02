import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
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
      listenWhen: _listenWhen,
      listener: _redirectListener,
      child: Form(
        key: _formKey,
        onChanged: _onChangedForm,
        child: OccludeWrapper(
          child: CustomTextField.email(
            key: const ValueKey('forgot_password_email_text_field'),
            controller: _emailController,
            textInputAction: TextInputAction.done,
          ),
        ),
      ),
    );
  }

  void _onChangedForm() => widget.onFormChanged(_emailController.text);

  void _redirectListener(BuildContext context, AuthenticationState state) {
    context.showSuccessBar(
      content: CustomText(
        LocalizedTexts.forgotEmailSuccessMessage.tr(
          {'email': _emailController.text},
        ),
      ),
      actions: [
        TextButton(
          onPressed: context.router.maybePop,
          child:  CustomText(LocalizedTexts.ok.tr().capitalize()),
        ),
      ],
    );

    state.mapOrNull(
      guest: (_) => context.router.pushNamed(AppRoutes.login),
      authenticated: (_) => context.router.maybePop(),
    );
  }

  bool _listenWhen(AuthenticationState previous, AuthenticationState current) {
    final previousEmail = previous.data.emailWasSend;
    final currentEmail = current.data.emailWasSend;
    final hasError = current.data.error != null;

    return previousEmail != currentEmail && currentEmail || hasError;
  }
}
