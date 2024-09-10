import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/physical_activities_type.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/toggle_button/custom_toggle_button.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/physical_activities_preferences_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/infrastructure/physical_activities_controller.dart';

class ActivityTypeChips extends StatefulWidget {
  final bool _profileInvoke;

  const ActivityTypeChips.green({super.key}) : _profileInvoke = false;

  const ActivityTypeChips.coral({super.key}) : _profileInvoke = true;

  @override
  State<ActivityTypeChips> createState() => _ActivityTypeChipsState();
}

class _ActivityTypeChipsState extends State<ActivityTypeChips> {
  late PhysicalActivitiesTypeController controller;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<PhysicalActivitiesPreferencesBloc>();
    controller = PhysicalActivitiesTypeController(length: 2, bloc: bloc);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PhysicalActivitiesType?>(
      valueListenable: controller.listener,
      builder: (context, type, _) {
        final width = MediaQuery.of(context).size.width - 55;
        return widget._profileInvoke
            ? CustomToggleButton.coral(
                customWidths: [width / 2, width / 2],
                inactiveBgColor: AppColors.blueLightest,
                textStyle: context.textTheme.bodySmall,
                customActiveTextStyles:
                    context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                initialIndex: controller.selection,
                onTap: (index) => controller.jumpToTab(index),
                children: PhysicalActivitiesType.values
                    .map(
                      (PhysicalActivitiesType value) => value.label,
                    )
                    .toList(),
              )
            : CustomToggleButton.green(
                customWidths: [width / 2, width / 2],
                inactiveBgColor: AppColors.blueLightest,
                textStyle: context.textTheme.bodySmall,
                customActiveTextStyles:
                    context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
                initialIndex: controller.selection,
                onTap: (index) => controller.jumpToTab(index),
                children: PhysicalActivitiesType.values
                    .map(
                      (PhysicalActivitiesType value) => value.label,
                    )
                    .toList(),
              );
      },
    );
  }
}
