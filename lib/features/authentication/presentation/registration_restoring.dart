import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';

registrationRestoring(
  StackRouter router,
  AuthenticationCubit authenticationCubit,
) {
  final isWelcomePage = authenticationCubit.state is Guest;
  final isNamePage = authenticationCubit.state is Name;
  final isPasswordPage = authenticationCubit.state is Password;
  final isEmailAddressPage = authenticationCubit.state is EmailAddress;
  final isWaitedForConfirmationPage =
      authenticationCubit.state is WaitedForConfirmation;

  if (isWelcomePage) {
    router.replaceNamed(AppRoutes.signUpWelcome);
  }

  if (isNamePage) {
    router.replaceAll(
      [const SignUpWelcomeRoute(), const NameRoute()].take(2).toList(),
    );

    return;
  }

  if (isPasswordPage) {
    router.replaceAll(
      [const SignUpWelcomeRoute(), const NameRoute(), const PasswordRoute()]
          .take(3)
          .toList(),
    );

    return;
  }

  if (isEmailAddressPage) {
    router.replaceAll(
      [
        const SignUpWelcomeRoute(),
        const NameRoute(),
        const PasswordRoute(),
        const EmailAddressRoute(),
      ].take(4).toList(),
    );

    return;
  }

  if (isWaitedForConfirmationPage) {
    router.replaceAll(
      [
        const SignUpWelcomeRoute(),
        const NameRoute(),
        const PasswordRoute(),
        const EmailAddressRoute(),
        const WaitingForConfirmationRoute(),
      ].take(5).toList(),
    );

    return;
  }
}
