import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/physical_activities_frequency.dart';
import 'package:loopcare_frontend/core/domain/physical_activities_type.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/physical_activities_preferences_bloc.dart';

@RoutePage()
class PhysicalPreferencesPage extends StatefulWidget {
  const PhysicalPreferencesPage({super.key});

  @override
  State<StatefulWidget> createState() => _PhysicalPreferencesPageState();
}

class _PhysicalPreferencesPageState extends State<PhysicalPreferencesPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blue(
      withBg: true,
      appBar: CustomAppBar.blue(
        title: LocalizedTexts.physicalActivitiesPreferences.tr(),
        leading: CustomFilledIconButton.leadingBlueLighter(),
      ),
      body: CustomSafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              children: [
                const SizedBox(height: 39.0),
                BlocBuilder<PhysicalActivitiesPreferencesBloc, PhysicalActivitiesPreferencesState>(
                    builder: (BuildContext context, state) {
                  return AccountContainer(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SectionItem(
                            title: LocalizedTexts.physicalActivitiesPreferencesItemTwo.tr(),
                            subTitle: _physicalActivitiesPreferencesFrequencySubtitle(state),
                            onPressHandler: () => _onPhysicalActivitiesFrequencyHandler(context)),
                        const Divider(height: 1.0, color: AppColors.blueLighter),
                        SectionItem(
                            title: LocalizedTexts.physicalActivitiesPreferencesItemThree.tr(),
                            subTitle: _physicalActivitiesPreferencesTargetSubtitle(state),
                            onPressHandler: () => _onPhysicalActivitiesHandler(context, state)),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _physicalActivitiesPreferencesFrequencySubtitle(PhysicalActivitiesPreferencesState state) {
    var perWeek = "";
    var frequency = "";
    if (state.data.currentTrainingFrequency != null) {
      frequency = state.data.currentTrainingFrequency?.label ?? "";
      if (state.data.currentTrainingFrequency != PhysicalActivitiesFrequency.notAble) {
        perWeek = LocalizedTexts.perWeek.tr();
      }
    }
    if (frequency.isEmpty && perWeek.isEmpty) return "";

    return "$frequency $perWeek";
  }

  String _physicalActivitiesPreferencesTargetSubtitle(PhysicalActivitiesPreferencesState state) {
    var target = '';

    if (state.data.currentTrainingFrequency != null) {
      if (state.data.currentTrainingFrequency != PhysicalActivitiesFrequency.notAble) {
        target = state.data.currentTrainingTargets?.label ?? "";
      }
    }
    return target;
  }

  void _onPhysicalActivitiesFrequencyHandler(BuildContext context) =>
      context.router.push(PhysicalActivitiesFrequencyRoute(profileInvoke: true));

  void _onPhysicalActivitiesHandler(BuildContext context, PhysicalActivitiesPreferencesState state) {
    if (state.data.needActivitiesType) {
      context.router.push(PhysicalActivitiesActivityTypeRoute(profileInvoke: true));
    }
  }
}
