import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/response_error_const.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/checkbox_form_field.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email.dart';

class EmailAddressForm extends StatefulWidget {
  const EmailAddressForm({super.key}) : _isUpdate = false;

  const EmailAddressForm.update({super.key}) : _isUpdate = true;

  final bool _isUpdate;

  @override
  State<EmailAddressForm> createState() => _EmailAddressFormState();
}

class _EmailAddressFormState extends State<EmailAddressForm> {
  late TextEditingController _passwordController;

  final _formValidNotifier = ValueNotifier<bool>(false);
  final _emailErrorTextNotifier = ValueNotifier<String?>(null);
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _receiveAnEmails = false;

  @override
  void initState() {
    super.initState();
    final password = context.read<AuthenticationBloc>().state.data.password;
    _passwordController = TextEditingController(text: password);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _formValidNotifier.dispose();
    _emailErrorTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: _errorListener,
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listenWhen: (previous, current) => !previous.data.emailWasSend && current.data.emailWasSend,
          listener: _blockButtonListener,
        ),
      ],
      child: Form(
        key: _formKey,
        onChanged: _onChangedForm,
        child: AutofillGroup(
          onDisposeAction: widget._isUpdate
              ? AutofillContextAction.commit
              : AutofillContextAction.cancel,
          child: Column(
            children: [
              ValueListenableBuilder<String?>(
                valueListenable: _emailErrorTextNotifier,
                builder: (context, error, _) {
                  return CustomTextField.email(
                    key: const ValueKey('registration_email_text_field'),
                    controller: _emailController,
                    errorText: error,
                    onChanged: _onEmailChanged,
                  );
                },
              ),
              if (!widget._isUpdate) ...[
                const SizedBox(height: 8.0),
                CheckboxFormField(
                  key: const ValueKey('registration_receive_email_checkbox'),
                  errorText: '',
                  text: CustomText(
                    '${LocalizedTexts.receiveEmailCheckboxLabel.tr()} ',
                    style: context.textTheme.bodyMedium,
                  ),
                  onChanged: _onReceiveEmailChanged,
                ),
              ],
              if (widget._isUpdate)
                SizedBox(
                  height: 16.0,
                  child: Opacity(
                    opacity: 0.0,
                    child: CustomTextField.hiddenPassword(
                      key: const ValueKey('registration_hidden_password'),
                      controller: _passwordController,
                    ),
                  ),
                ),
              ValueListenableBuilder(
                valueListenable: _formValidNotifier,
                builder: (context, isValid, _) {
                  final label = widget._isUpdate
                      ? LocalizedTexts.update.tr()
                      : LocalizedTexts.next.tr();

                  return CustomElevatedButton.blueFullWidth(
                    key: const ValueKey('registration_next_button'),
                    onPressed: isValid ? _onNextPressed : null,
                    label: label,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onChangedForm() => _formValidNotifier.value = Email.create(_emailController.text).isRight();

  void _onNextPressed() {
    if (widget._isUpdate) {
      TextInput.finishAutofillContext();
    }

    context.read<AuthenticationBloc>().add(
        AuthenticationEvent.updateEmail(
          email: _emailController.text,
          receiveAnEmails: _receiveAnEmails,
          update: widget._isUpdate,
        ),
      );
  }

  void _onReceiveEmailChanged(bool? value) => _receiveAnEmails = value!;

  void _onEmailChanged(String value) {
    if (_emailErrorTextNotifier.value != null) {
      _emailErrorTextNotifier.value = null;
    }
  }

  void _errorListener(BuildContext context, AuthenticationState state) {
    final error = state.data.error;
    if (error != null) {
      final errorMessage = error.maybeMap(
        badRequest: (value) {
          final message = error.error.message;
          if (message == accountAlreadyExists) {
            _emailErrorTextNotifier.value = LocalizedTexts.emailAlreadyTaken.tr();
            return null;
          } else {
            return LocalizedTexts.somethingIsIncorrect.tr();
          }
        },
        forbidden: (forbidden) =>
            (forbidden.error.message != null) ? forbidden.error.message! : LocalizedTexts.somethingIsIncorrect.tr(),
        orElse: () => LocalizedTexts.somethingIsIncorrect.tr(),
      );

      if (errorMessage != null) {
        context.showError(content: Text(errorMessage));
      }
    }
  }

  void _blockButtonListener(BuildContext context, AuthenticationState state) =>
      _formValidNotifier.value = false;
}
