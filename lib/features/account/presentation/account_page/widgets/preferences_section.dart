import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_title.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/physical_activities_preferences_bloc.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({super.key});

  void _onFoodHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.foodPreferences);
  }

  void _onPhysicalActivitiesHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.physicalPreferences);
  }

  void _onGroupSessionsHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.groupPreferences);
  }

  String _groupSessionsSubtitle(AuthenticationState state) {
    var grouped =
        state.isUserGrouped ? LocalizedTexts.yes.translation.capitalize() : LocalizedTexts.no.translation.capitalize();

    return "${LocalizedTexts.partOfGroup.translation}: $grouped";
  }

  bool _whenFoodUpdated(
    YouAndFoodState previous,
    YouAndFoodState current,
  ) {
    return !previous.saved && current.saved;
  }

  Future<void> _foodUpdatedListener(BuildContext context, YouAndFoodState state) async {
    context.showCustomSuccessBar(
      content: CustomText.w600(
        LocalizedTexts.yourPreferencesUpdated.tr(namedArgs: {
          'prefName': LocalizedTexts.food.tr(),
        }),
        style: context.textTheme.bodySmall,
      ),
    );
  }

  bool _whenPhysicalActivitiesUpdated(
    PhysicalActivitiesPreferencesState previous,
    PhysicalActivitiesPreferencesState current,
  ) {
    return previous is Saving && current is PreferencesLoaded;
  }

  Future<void> _physicalActivitiesUpdatingListener(
      BuildContext context, PhysicalActivitiesPreferencesState state) async {
    context.showCustomSuccessBar(
      content: CustomText.w600(
        LocalizedTexts.yourPreferencesUpdated.tr(
          namedArgs: {
            'prefName': LocalizedTexts.physicalExercises.tr().toLowerCase(),
          },
        ),
        style: context.textTheme.bodySmall,
      ),
    );
  }

  bool _whenGroupUpdated(
    GroupPreferencesState previous,
    GroupPreferencesState current,
  ) {
    return previous is GroupPreferencesLoading && current is GroupPreferencesUpdated;
  }

  Future<void> _groupUpdatingListener(BuildContext context, GroupPreferencesState state) async {
    context.showCustomSuccessBar(
      content: CustomText.w600(
        LocalizedTexts.yourPreferencesUpdated.tr(
          namedArgs: {
            'prefName': LocalizedTexts.group.tr().toLowerCase(),
          },
        ),
        style: context.textTheme.bodySmall,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<YouAndFoodBloc, YouAndFoodState>(
          listenWhen: _whenFoodUpdated,
          listener: _foodUpdatedListener,
        ),
        BlocListener<PhysicalActivitiesPreferencesBloc, PhysicalActivitiesPreferencesState>(
          listenWhen: _whenPhysicalActivitiesUpdated,
          listener: _physicalActivitiesUpdatingListener,
        ),
        BlocListener<GroupPreferencesBloc, GroupPreferencesState>(
          listenWhen: _whenGroupUpdated,
          listener: _groupUpdatingListener,
        ),
      ],
      child: AccountContainer(
        child: Column(
          children: [
            SectionTitle(title: LocalizedTexts.preferences.tr()),
            BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                return SectionItem(
                  title: LocalizedTexts.food.tr(),
                  onPressHandler: state.isFoodLoggingUnlocked ? () => _onFoodHandler(context) : null,
                );
              },
            ),
            const Divider(height: 1.0, color: AppColors.blueLighter),
            BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                return SectionItem(
                  title: LocalizedTexts.physicalExercises.tr(),
                  onPressHandler: state.unlockedFeatures.contains(UnlockedFeatureType.physicalActivities)
                      ? () => _onPhysicalActivitiesHandler(context)
                      : null,
                );
              },
            ),
            const Divider(height: 1.0, color: AppColors.blueLighter),
            BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                return SectionItem(
                  title: LocalizedTexts.groupSessions.tr(),
                  subTitle: _groupSessionsSubtitle(state),
                  onPressHandler: state.isGroupSessionsUnlocked ? () => _onGroupSessionsHandler(context) : null,
                );
              },
            ),
            // Todo it's old part, need to check do we need it in future
            // const SizedBox(height: 16.0),
            // const Divider(height: 1.0, color: AppColors.blueLighter),
            // const SizedBox(height: 16.0),
            // SectionItem(title: LocalizedTexts.diabetes.tr(), onPressHandler: () {}),
          ],
        ),
      ),
    );
  }
}
