import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email.dart';
import 'package:loopcare_frontend/features/authentication/domain/login_password/login_password.dart';

@RoutePage()
class UpdateEmailPage extends StatefulWidget {
  const UpdateEmailPage({super.key});

  @override
  State<UpdateEmailPage> createState() => _UpdateEmailPageState();
}

class _UpdateEmailPageState extends State<UpdateEmailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isFormValid = ValueNotifier(false);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onFormChangedHandler() =>
      _isFormValid.value = Email.create(_emailController.text).isRight() &&
          LoginPassword.create(_passwordController.text).isRight();

  void _onForgotMyPassword() => context.router.pushNamed(AppRoutes.forgotPassword);

  void _onSubmitHandler() =>
      context.read<AuthenticationBloc>().add(AuthenticationEvent.updateUserEmail(
            email: _emailController.text,
            password: _passwordController.text,
          ));

  void _onModalCloseHandler() => context.router.popUntilRouteWithName(HomeRoute.name);

  void _onEmailWasUpdated(_) {
    ModalBottomSheet.emailChangeConfirmed(
      context: context,
      onCloseCallback: _onModalCloseHandler,
    );
  }

  void _onErrorUpdateEmail(AuthenticationState s) {
    final message = s.data.error?.message ?? LocalizedTexts.errorSomethingWentWrong;
    context.showError(content: CustomText(message.tr()));
  }

  void _onEmailChangeListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(
      errorUpdateEmail: _onErrorUpdateEmail,
      emailWasUpdated: _onEmailWasUpdated,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: _onEmailChangeListener,
      child: CustomScaffold.blue(
        appBar: CustomAppBar.blue(
          title: LocalizedTexts.account.tr(),
          leading: CustomFilledIconButton.leadingBlueLighter(),
        ),
        body: CustomSafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                children: [
                  const SizedBox(height: 32.0),
                  AutofillGroup(
                    child: Form(
                      key: _formKey,
                      onChanged: _onFormChangedHandler,
                      child: AccountContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.bitter500(
                              LocalizedTexts.changeYourEmail.tr(),
                              style: context.textTheme.displayMedium,
                            ),
                            const SizedBox(height: 20.0),
                            CustomText.w400(
                              LocalizedTexts.changeYourEmailDescription.tr(),
                              style: context.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 20.0),
                            OccludeWrapper(
                              child: Column(
                                children: [
                                  CustomTextField.email(
                                    key: const ValueKey('email_text_field'),
                                    controller: _emailController,
                                  ),
                                  const SizedBox(height: 20.0),
                                  CustomTextField.password(
                                    key: const ValueKey('password_text_field'),
                                    controller: _passwordController,
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: _onForgotMyPassword,
                              child: CustomText.w400(
                                '${LocalizedTexts.forgotPasswordTitle.tr()}?',
                                style: context.textTheme.bodySmall,
                              ),
                            ),
                            BlocBuilder<AuthenticationBloc, AuthenticationState>(
                              builder: (context, state) {
                                final isLoading =
                                    state.maybeMap(orElse: () => false, isLoading: (_) => true);

                                return ValueListenableBuilder<bool>(
                                  valueListenable: _isFormValid,
                                  builder: (context, isValid, _) =>
                                      CustomElevatedButton.blueFullWidth(
                                    key: const ValueKey('submit_btn'),
                                    label: LocalizedTexts.submit.tr(),
                                    onPressed: isValid ? _onSubmitHandler : null,
                                    isLoading: isLoading,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _isFormValid.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
