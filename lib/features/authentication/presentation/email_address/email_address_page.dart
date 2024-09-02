import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email.dart';
import 'package:loopcare_frontend/features/authentication/presentation/email_address/widgets/email_address_form.dart';

@RoutePage()
class EmailAddressPage extends StatefulWidget {
  const EmailAddressPage({super.key});

  @override
  State<EmailAddressPage> createState() => _EmailAddressPageState();
}

class _EmailAddressPageState extends State<EmailAddressPage> {
  final _formValidNotifier = ValueNotifier<bool>(false);
  String _email = '';
  bool _receiveAnEmails = false;

  @override
  void dispose() {
    _formValidNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userName = context.read<AuthenticationBloc>().state.data.nameCapitalised;

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listenWhen: _listenWhen,
          listener: _navigationListener,
        ),
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listenWhen: (previous, current) => !previous.data.emailWasSend && current.data.emailWasSend,
          listener: _blockButtonListener,
        ),
      ],
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: CustomScaffold.blueLightest(
          key: const ValueKey('email_address_page'),
          appBar: CustomAppBar.blue(
            title: LocalizedTexts.email.tr(),
            leading: CustomFilledIconButton.leadingBlueLighter(),
          ),
          body: CustomSafeArea(
            child: BottomPlacedButton.blueLightest(
              body: MainContainer(
                child: Column(
                  key: const ValueKey('email_page_body'),
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 35.0),
                    CustomText.bitter700(
                      '${LocalizedTexts.niceToMeetYou.tr()}, $userName!',
                      style: context.textTheme.displayMedium,
                    ),
                    const SizedBox(height: 27.0),
                    CustomText.w400(
                      '${LocalizedTexts.emailTitle.tr()}.',
                      style: context.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 28.0),
                    EmailAddressForm(
                      key: const ValueKey('email_form'),
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
                    label: LocalizedTexts.next.tr(),
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
    _receiveAnEmails = receiveAnEmails;
    _formValidNotifier.value = Email.create(_email).isRight();
  }

  void _onNextPressed() => context.read<AuthenticationBloc>().add(
        AuthenticationEvent.updateEmail(
          email: _email,
          receiveAnEmails: _receiveAnEmails,
          update: false,
        ),
      );

  bool _listenWhen(AuthenticationState previous, AuthenticationState current) =>
      (ModalRoute.of(context)?.isCurrent ?? false) &&
          !previous.data.emailVerified &&
          current.data.emailVerified;

  void _navigationListener(BuildContext context, AuthenticationState state) =>
      context.router.pushNamed(AppRoutes.onboardingQuestions);

  void _blockButtonListener(BuildContext context, AuthenticationState state) =>
      _formValidNotifier.value = false;
}
