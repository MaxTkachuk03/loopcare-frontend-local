import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email.dart';
import 'package:loopcare_frontend/features/authentication/presentation/email_address/widgets/email_address_form.dart';
import 'package:loopcare_frontend/features/onboarding/application/medical_questions/medical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/mental_questions/mental_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/physical_questions/physical_questions_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class ChangeEmailAddressPage extends StatefulWidget {
  const ChangeEmailAddressPage({super.key});

  @override
  State<ChangeEmailAddressPage> createState() => _ChangeEmailAddressPageState();
}

class _ChangeEmailAddressPageState extends State<ChangeEmailAddressPage> {
  final _formValidNotifier = ValueNotifier<bool>(false);
  String _email = '';

  @override
  void dispose() {
    _formValidNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listenWhen: (previous, current) =>
              !previous.data.emailVerified && current.data.emailVerified,
          listener: _emailValidationListener,
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listenWhen: (previous, current) =>
              !previous.data.emailWasSend && current.data.emailWasSend,
          listener: _navigationListener,
        ),
      ],
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: CustomScaffold.blueLightest(
          key: const ValueKey('change_email_address_page'),
          appBar: CustomAppBar.blue(
            title: LocalizedTexts.changeEmail.tr(),
            leading: CustomFilledIconButton.leadingBlueLighter(),
          ),
          body: CustomSafeArea(
            child: BottomPlacedButton.blueLightest(
              body: MainContainer(
                child: Column(
                  key: const ValueKey('change_email_page_body'),
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 35.0),
                    CustomText.bitter700(
                      LocalizedTexts.changeAddress.tr(),
                      style: context.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 27.0),
                    CustomText.w400(
                      '${LocalizedTexts.changeEmailAddressTitle.tr()}.',
                      style: context.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 28.0),
                    EmailAddressForm.update(
                      key: const ValueKey('change_email_form'),
                      onFormChanged: _onFormChanged,
                    ),
                  ],
                ),
              ),
              button: ValueListenableBuilder(
                valueListenable: _formValidNotifier,
                builder: (context, isValid, _) {
                  return CustomElevatedButton.blueFullWidth(
                    key: const ValueKey('registration_next_button'),
                    onPressed: isValid ? _onNextPressed : null,
                    label: LocalizedTexts.update.tr(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onFormChanged(String email, bool receiveAnEmails) {
    _email = email;
    _formValidNotifier.value = Email.create(_email).isRight();
  }

  void _onNextPressed() {
    TextInput.finishAutofillContext();

    context.read<AuthenticationBloc>().add(
          AuthenticationEvent.updateEmail(
            email: _email,
            update: true,
          ),
        );
  }

  Future<void> _emailValidationListener(BuildContext context, AuthenticationState state) async {
    final physicalData =
        context.read<PhysicalQuestionsBloc>().state.registrationPhysicalQuestionsData;
    final medicalData = context.read<MedicalQuestionsBloc>().state.registrationData;
    final mentalData = context.read<MentalQuestionsBloc>().state.registrationData;
    final authBloc = context.read<AuthenticationBloc>();

    authBloc.add(
      AuthenticationEvent.signUp(
        password: authBloc.state.data.password,
        registrationPhysicalFitnessData: physicalData,
        medicalOnboarding: medicalData,
        mentalHealthTest: mentalData,
      ),
    );
  }

  void _navigationListener(BuildContext context, AuthenticationState state) {
    _formValidNotifier.value = false;
    context.router.maybePop();
  }
}
