import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/diabetes/application/diabetes_bloc.dart';
import 'package:loopcare_frontend/features/preferences/presentation/preferences_overview/widgets/preferences_list.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';

class PreferencesOverviewPage extends StatelessWidget {
  const PreferencesOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationCubit, AuthenticationState>(
          listenWhen: (prev, current) => prev is Authenticated && current is Guest,
          listener: _logOutListener,
        ),
        BlocListener<AuthenticationCubit, AuthenticationState>(
          listenWhen: (prev, current) => current is Authenticated && current.isPreferencesComplete,
          listener: _preferencesComplete,
        ),
        BlocListener<YouAndFoodBloc, YouAndFoodState>(
          listenWhen: (prev, cur) => !prev.isCompleted && cur.isCompleted,
          listener: (BuildContext context, _) => _updateAccount(context),
        ),
        BlocListener<DiabetesBloc, DiabetesState>(
          listenWhen: (prev, cur) => !prev.isCompleted && cur.isCompleted,
          listener: (BuildContext context, _) => _updateAccount(context),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70.0,
                  ),
                  Text(
                    LocalizedTexts.preferencesOverview.tr(),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontFamily: ThemeConstants.bitterFontFamily,
                          color: AppColors.blueDark,
                        ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    LocalizedTexts.preferencesOverviewDescription.tr(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  ),
                  const SizedBox(
                    height: 28.0,
                  ),
                  Text(
                    LocalizedTexts.preferencesOverviewLeftSurveys.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const PreferencesList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _logOutListener(BuildContext context, AuthenticationState state) {
    context.router.replaceAll([const IntroRoute()]);
  }

  void _updateAccount(BuildContext context) {
    context.read<AuthenticationCubit>().getAccount();
  }

  void _preferencesComplete(BuildContext context, AuthenticationState state) {
    ModalBottomSheet.surveyFinishedMessage(
      context: context,
      onBtnPress: () {
        context.router.replaceAll([const HomeRoute()]);
      },
    );
  }
}
