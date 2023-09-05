import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_title.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({Key? key}) : super(key: key);

  void _onFoodHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.foodPreferences);
  }

  void _onPhysicalActivitiesHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.physicalActivitiesPreferences);
  }

  void _onGroupSessionsHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.groupPreferences);
  }

  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      child: Column(
        children: [
          const SectionTitle(title: LocalizedTexts.preferences),
          SectionItem(title: LocalizedTexts.food, onPressHandler: () => _onFoodHandler(context)),
          const SizedBox(height: 16.0),
          const Divider(height: 1.0, color: AppColors.yellowLight),
          const SizedBox(height: 16.0),
          SectionItem(
              title: LocalizedTexts.physicalActivities,
              onPressHandler: () => _onPhysicalActivitiesHandler(context)),
          const SizedBox(height: 16.0),
          const Divider(height: 1.0, color: AppColors.yellowLight),
          const SizedBox(height: 16.0),
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              return SectionItem(
                  title: LocalizedTexts.groupSessions,
                  onPressHandler: state.groupingState == UserGroupingState.locked
                      ? null
                      : () => _onGroupSessionsHandler(context));
            },
          ),
          const SizedBox(height: 16.0),
          const Divider(height: 1.0, color: AppColors.yellowLight),
          const SizedBox(height: 16.0),
          SectionItem(title: LocalizedTexts.diabetes, onPressHandler: () {}),
        ],
      ),
    );
  }
}
