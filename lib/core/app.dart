import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/routes/intro_guard.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/consent_confirmation/application/consent_confirmation_bloc.dart';
import 'package:loopcare_frontend/features/legal_statement/application/legal_statement_bloc.dart';
import 'package:loopcare_frontend/features/medical_fitness/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/onboarding_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';
import 'package:loopcare_frontend/injection.dart';

final autoRouteObserver = AutoRouteObserver();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<PhysicalFitnessBloc>(
          create: (_) => getIt<PhysicalFitnessBloc>(),
        ),
        BlocProvider<MedicalFitnessBloc>(
          create: (_) => getIt<MedicalFitnessBloc>(),
        ),
        BlocProvider<OnboardingBloc>(
          create: (_) => getIt<OnboardingBloc>(),
        ),
        BlocProvider<AuthenticationCubit>(
          create: (_) => getIt<AuthenticationCubit>(),
        ),
        BlocProvider<LegalStatementBloc>(
          create: (_) => getIt<LegalStatementBloc>(),
        ),
        BlocProvider<ConsentConfirmationBloc>(
          create: (_) => getIt<ConsentConfirmationBloc>(),
        ),
        BlocProvider<YouAndFoodBloc>(
          create: (_) => getIt<YouAndFoodBloc>(),
        ),
      ],
      child: const _App(),
    );
  }
}

class _App extends StatefulWidget {
  const _App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<_App> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    final authBloc = context.read<AuthenticationCubit>();
    final onboardingBloc = context.read<OnboardingBloc>();
    final legalStatementBloc = context.read<LegalStatementBloc>();
    final consentConfirmationBloc = context.read<ConsentConfirmationBloc>();

    _appRouter = AppRouter(
      introGuard: IntroGuard(
        authBloc,
        onboardingBloc,
        consentConfirmationBloc,
        legalStatementBloc,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Loop care',
      theme: appThemeData,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
