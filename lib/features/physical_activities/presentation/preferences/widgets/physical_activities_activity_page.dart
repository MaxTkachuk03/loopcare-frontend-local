import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/physical_activities_preferences_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/preferences/widgets/activity_type_chips.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/preferences/widgets/flexibility_chips.dart';

class PhysicalActivitiesActivityTypePage extends StatefulWidget {
  const PhysicalActivitiesActivityTypePage({super.key});

  @override
  State<PhysicalActivitiesActivityTypePage> createState() => _PhysicalActivitiesActivityTypePageState();
}

class _PhysicalActivitiesActivityTypePageState extends State<PhysicalActivitiesActivityTypePage> {
  void _onErrorHandler(PhysicalActivitiesPreferencesState state) =>
      context.showError(content: Text(state.data.error?.error.toString() ?? ''));

  void _onChangeListener(BuildContext context, PhysicalActivitiesPreferencesState state) {
    state.maybeMap(
      orElse: () => {},
      error: _onErrorHandler,
      preferencesLoaded: _onUpdateHandler,
    );
  }

  void _onUpdateHandler(PhysicalActivitiesPreferencesState state) {
    final bloc = context.read<AuthenticationCubit>();
    bloc.getAccount();
    if (!bloc.state.unlockedFeatures.contains(UnlockedFeatureType.physicalActivities)) {
      context.router.pushNamed(AppRoutes.physicalActivitiesComplete);
    } else {
      context.router.pop();
    }
  }

  void _onNext(BuildContext context) {
    context.read<PhysicalActivitiesPreferencesBloc>().add(const PhysicalActivitiesPreferencesEvent.savePreferences());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhysicalActivitiesPreferencesBloc, PhysicalActivitiesPreferencesState>(
      listenWhen: (prev, cur) =>
          prev is Saving && context.router.current.name == PhysicalActivitiesActivityTypeRoute.name,
      listener: _onChangeListener,
      child: CustomScaffold.blueLightest(
        appBar: CustomAppBar.blue(
          title: LocalizedTexts.trainingFocus.tr(),
          leading: CustomFilledIconButton.leadingBlueLighter(),
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 30.0),
                      CustomText.bitter500(
                        LocalizedTexts.whatWouldYouLikeToStartWorkingOn.translation,
                        style: context.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 28.0),
                      const ActivityTypeChips(),
                      const SizedBox(height: 28.0),
                      CustomText.w400(
                        LocalizedTexts.youCanAlsoOptionally.translation,
                        style: context.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 28.0),
                      BlocBuilder<PhysicalActivitiesPreferencesBloc, PhysicalActivitiesPreferencesState>(
                        builder: (context, state) {
                          return state.data.needFlexibility ? const FlexibilityChips() : const SizedBox(height: 0.0);
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      BlocBuilder<PhysicalActivitiesPreferencesBloc, PhysicalActivitiesPreferencesState>(
                        builder: (context, state) {
                          return CustomElevatedButton.blueFullWidth(
                            onPressed: () => state.data.isTargetsSet ? _onNext(context) : null,
                            label: LocalizedTexts.confirm.tr(),
                          );
                        },
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
