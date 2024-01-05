import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/domain/sex_type.dart';

class GenderPrefsGuard extends AutoRouteGuard {
  AuthenticationCubit authenticationCubit;

  GenderPrefsGuard(this.authenticationCubit);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final gender = authenticationCubit.state.gender;

    if (gender == SexType.female || gender == SexType.male) {
      resolver.next(true);
    } else {
      router.replaceNamed(AppRoutes.timezone);
    }
  }
}
