import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/preferences/presentation/preferences_overview/widgets/preferences_list.dart';

class PreferencesOverviewPage extends StatelessWidget {
  const PreferencesOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listenWhen: (prev, current) => prev is Authenticated && current is Guest,
      listener: _logOutListener,
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
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          fontFamily: ThemeConstants.bitterFontFamily,
                          color: AppColors.blueDark,
                        ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    LocalizedTexts.preferencesOverviewDescription.tr(),
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(),
                  ),
                  const SizedBox(
                    height: 28.0,
                  ),
                  Text(
                    LocalizedTexts.preferencesOverviewLeftSurveys.tr(),
                    style: Theme.of(context).textTheme.headline5,
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
}
