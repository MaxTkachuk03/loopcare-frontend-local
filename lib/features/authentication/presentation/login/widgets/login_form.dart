import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/application/app_update/app_update_bottom_sheet.dart';
import 'package:loopcare_frontend/core/infrastructure/services/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_event_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/authentication/domain/email/email.dart';
import 'package:loopcare_frontend/features/authentication/domain/login_password/login_password.dart';
import 'package:loopcare_frontend/features/home/application/navigation_bar_bloc.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/injection.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formValidationNotifier = ValueNotifier<bool>(false);
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _formValidationNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: _authenticationListener,
        ),
        BlocListener<RiverBloc, RiverState>(
          listener: (context, state) {
            state.mapOrNull(
              moduleLoaded: _onRiverModulesLoaded,
            );
          },
        )
      ],
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return AutofillGroup(
            child: Form(
              key: _formKey,
              onChanged: _onChangedForm,
              child: Column(
                children: [
                  OccludeWrapper(
                    child: Column(
                      children: [
                        CustomTextField.loginEmail(
                          key: const ValueKey('login_email_text_field'),
                          controller: _emailController,
                        ),
                        const SizedBox(height: 12.0),
                        CustomTextField.password(
                          key: const ValueKey('login_password_text_field'),
                          controller: _passwordController,
                          onEditingComplete: TextInput.finishAutofillContext,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  ValueListenableBuilder<bool>(
                    valueListenable: _formValidationNotifier,
                    builder: (context, isValid, _) {
                      return Builder(builder: (context) {
                        final authState = context.watch<AuthenticationBloc>().state;
                        final riverState = context.watch<RiverBloc>().state.data;

                        final isLoading =
                            authState is AuthenticationStateIsLoading || riverState.isLoading;

                        return CustomElevatedButton.blueFullWidth(
                          key: const ValueKey('login_button'),
                          onPressed: isValid ? _onLogin : null,
                          label: LocalizedTexts.login.tr(),
                          isLoading: isLoading,
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onChangedForm() {
    final isValidForm = Email.create(_emailController.text).isRight() &&
        LoginPassword.create(_passwordController.text).isRight();

    _formValidationNotifier.value = isValidForm;
  }

  void _onLogin() {
    TextInput.finishAutofillContext();

    context.read<NavigationBarBloc>().add(const NavigationBarEvent.init());
    context.read<AuthenticationBloc>().add(
          AuthenticationEvent.login(
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
  }

  void _authenticationListener(BuildContext context, AuthenticationState state) {
    state.mapOrNull(
      needUpdatePolicies: _updatePolicies,
      gotAccount: _onGetAccount,
      authenticated: _onAuthorized,
      guest: _onGuest,
    );
  }

  void _updatePolicies(NeedUpdatePolicies state) {
    final storage = getIt<SharedStorageService>();
    final updatePrivacyPolicy =
        storage.privacyPolicyVersion > (state.data.account?.privacyPolicyVersion ?? 1);
    final updateTermsAndConditions =
        storage.termsAndConditionsVersion > (state.data.account?.termsAndConditionsVersion ?? 1);

    AppUpdateBottomSheet.showPoliciesUpdate(
      updatePrivacyPolicy: updatePrivacyPolicy,
      updateTermsAndConditions: updateTermsAndConditions,
      onConfirmed: () => context.read<AuthenticationBloc>().add(
            AuthenticationEvent.updatePolicy(
              privacyPolicyVersion: storage.privacyPolicyVersion,
              termsAndConditionsVersion: storage.termsAndConditionsVersion,
            ),
          ),
    );
  }

  void _onRiverModulesLoaded(RiverState state) {
    final navigationBarBloc = context.read<NavigationBarBloc>();

    if (!state.data.isBeginningComplete ||
        !navigationBarBloc.state.data.isProfileOpen ||
        !navigationBarBloc.state.data.isPracticeOpen) {
      navigationBarBloc.add(
        NavigationBarEvent.setBeginningUncompleted(
          isPracticeOpened: state.data.isPracticeCompleted,
          isProfileOpened: state.data.isProfileCompleted,
        ),
      );
    }

    String route = AppRoutes.home;
    final authState = context.read<AuthenticationBloc>().state;

    if (!(authState.data.account?.hasActiveSubscription ?? false) && kIsProd) {
      route = AppRoutes.subscription;
    } else if (!state.data.isBeginningComplete && !state.data.isBeginningStarted) {
      route = AppRoutes.riverOverview;
    } else {
      route = AppRoutes.home;
    }

    MixpanelEventService.instance.track(
      AppMixpanelEvents.loginSuccess,
      parameters: {
        'userId': authState.data.accountId,
        'email': authState.data.email,
        'nextRoute': route,
      },
    );

    pushNamedAndClearStack(context, route);
  }

  void _onGetAccount(_) {
    context.read<RiverBloc>().add(const RiverEvent.init());
    context.read<RiverBloc>().add(const RiverEvent.getModules());
  }

  void _onAuthorized(_) {
    context.read<AuthenticationBloc>().add(const AuthenticationEvent.getAccount());
    context.read<AuthenticationBloc>().add(const AuthenticationEvent.sendApsFlyerData());
  }

  void _onGuest(GuestAuthenticationState state) {
    final error = state.data.error;
    if (error != null) {
      context.showError(content: CustomText(error.message.tr()));
    }
  }

  Future<dynamic> pushNamedAndClearStack(BuildContext context, String path) {
    context.router.popUntilRoot();
    return context.router.replaceNamed(path);
  }
}
