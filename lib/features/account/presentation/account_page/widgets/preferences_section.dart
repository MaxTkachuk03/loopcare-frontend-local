import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/account/application/group_preferences_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_title.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_bloc.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/home/application/navigation_bar_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/physical_activities_preferences_bloc.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';

class PreferencesSection extends StatefulWidget {
  const PreferencesSection({super.key});

  @override
  State<PreferencesSection> createState() => _PreferencesSectionState();
}

class _PreferencesSectionState extends State<PreferencesSection> {
  @override
  void initState() {
    super.initState();

    final authBloc = context.read<AuthenticationBloc>();

    context.read<BuddyBloc>().add(BuddyEvent.updateBuddyState(authBloc.state.data.account));
  }

  void _onFoodHandler(BuildContext context) {
    context.router.push(FoodPreferencesRoute(fromLessonComplete: false));
  }

  void _onBuddyHandler(BuildContext context) {
    context.read<AuthenticationBloc>().add(const AuthenticationEvent.buddyVisited());
    context.read<NavigationBarBloc>().add(const NavigationBarEvent.removeProfileNotification());

    final buddyWasNotInvited = context.read<BuddyBloc>().state.data.buddyState == null;
    final route = buddyWasNotInvited ? AppRoutes.buddyIntro : AppRoutes.buddyPreferences;

    context.router.pushNamed(route);
  }

  void _onPhysicalActivitiesHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.physicalPreferences);
  }

  void _onGroupSessionsHandler(BuildContext context) {
    context.router.pushNamed(AppRoutes.groupPreferences);
  }

  String _groupSessionsSubtitle(AuthenticationState state) {
    final grouped = state.data.isUserGrouped
        ? LocalizedTexts.yes.tr().capitalize()
        : LocalizedTexts.no.tr().capitalize();

    return "${LocalizedTexts.partOfGroup.tr()}: $grouped";
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
    context.read<AuthenticationBloc>().add(const AuthenticationEvent.getAccount());
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

  void _onAccountUpdated(BuildContext context, AuthenticationState state) {
    context.read<BuddyBloc>().add(BuddyEvent.updateBuddyState(state.data.account));
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
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: _onAccountUpdated,
        ),
      ],
      child: AccountContainer(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return Column(
              children: [
                SectionTitle(title: LocalizedTexts.preferences.tr()),
                SectionItem(
                  title: LocalizedTexts.food.tr(),
                  onPressHandler:
                      state.data.isFoodLoggingUnlocked ? () => _onFoodHandler(context) : null,
                ),
                const Divider(height: 1.0, color: AppColors.blueLighter),
                SectionItem(
                  title: LocalizedTexts.buddyTitle.tr(),
                  showNews: state.data.showBuddyNews,
                  onPressHandler:
                      state.data.isBuddyUnlocked ? () => _onBuddyHandler(context) : null,
                ),
                const Divider(height: 1.0, color: AppColors.blueLighter),
                SectionItem(
                  title: LocalizedTexts.physicalExercises.tr(),
                  onPressHandler: state.data.isPhysicalActivitiesUnlocked
                      ? () => _onPhysicalActivitiesHandler(context)
                      : null,
                ),
                const Divider(height: 1.0, color: AppColors.blueLighter),
                SectionItem(
                  title: LocalizedTexts.groupSessions.tr(),
                  subTitle: _groupSessionsSubtitle(state),
                  onPressHandler: state.data.isGroupSessionsUnlocked
                      ? () => _onGroupSessionsHandler(context)
                      : null,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
