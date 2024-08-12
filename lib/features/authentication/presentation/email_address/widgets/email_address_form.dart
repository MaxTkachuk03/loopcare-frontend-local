import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/checkbox_form_field.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';

class EmailAddressForm extends StatefulWidget {
  const EmailAddressForm({
    super.key,
    required this.onFormChanged,
  }) : _isUpdate = false;

  const EmailAddressForm.update({
    super.key,
    required this.onFormChanged,
  }) : _isUpdate = true;

  final bool _isUpdate;
  final void Function(String email, bool value) onFormChanged;

  @override
  State<EmailAddressForm> createState() => _EmailAddressFormState();
}

class _EmailAddressFormState extends State<EmailAddressForm> {
  late TextEditingController _passwordController;

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
    _emailErrorTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: _errorListener,
      child: Form(
        key: _formKey,
        onChanged: _onChangedForm,
        child: AutofillGroup(
          onDisposeAction:
              widget._isUpdate ? AutofillContextAction.commit : AutofillContextAction.cancel,
          child: Column(
            children: [
              ValueListenableBuilder<String?>(
                valueListenable: _emailErrorTextNotifier,
                builder: (context, error, _) {
                  return OccludeWrapper(
                    child: CustomTextField.email(
                      key: const ValueKey('registration_email_text_field'),
                      controller: _emailController,
                      errorText: error,
                      onChanged: _onEmailChanged,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              if (!widget._isUpdate)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: CheckboxFormField(
                    key: const ValueKey('registration_receive_email_checkbox'),
                    errorText: '',
                    text: CustomText(
                      '${LocalizedTexts.receiveEmailCheckboxLabel.tr()} ',
                      style: context.textTheme.bodyMedium,
                    ),
                    onChanged: _onReceiveEmailChanged,
                  ),
                ),
              if (widget._isUpdate)
                SizedBox(
                  height: 0.0,
                  child: Opacity(
                    opacity: 0.0,
                    child: CustomTextField.hiddenPassword(
                      key: const ValueKey('registration_hidden_password'),
                      controller: _passwordController,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  _onChangedForm() => widget.onFormChanged(_emailController.text, _receiveAnEmails);

  void _onReceiveEmailChanged(bool? value) => _receiveAnEmails = value!;

  void _onEmailChanged(String value) {
    if (_emailErrorTextNotifier.value != null) {
      _emailErrorTextNotifier.value = null;
    }
  }

  void _errorListener(BuildContext context, AuthenticationState state) {
    final error = state.data.error;
    if (error != null) {
      final message = error.message;
      if (message == LocalizedTexts.errorAccountIdAlreadyExists) {
        _emailErrorTextNotifier.value = message.tr();
      } else {
        context.showError(content: CustomText(message.tr()));
      }
    }
  }
}
