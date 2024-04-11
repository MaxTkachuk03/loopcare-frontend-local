import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/smart_goals/application/goal_progress_controller.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/progress_smart_goal_log.dart';

class DaySmartGoalChips extends StatefulWidget {
  final GoalProgressController controller;

  const DaySmartGoalChips({
    super.key,
    required this.controller,
  });

  @override
  State<DaySmartGoalChips> createState() => _DaySmartGoalChipsState();
}

class _DaySmartGoalChipsState extends State<DaySmartGoalChips> {
  void _onSelected(ProgressSmartGoalLog value) => setState(() {
        widget.controller.selectedValueNotifier.value = value;
      });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SmartGoalsBloc, SmartGoalsState>(
        listener: (context, state) => state.maybeMap(
              resetedLoggerTimes: (state) => widget.controller.selectedValueNotifier.value = state.data.logs.last,
              orElse: () => null,
            ),
        builder: (context, state) {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int i) {
              if (state.data.logs.isEmpty) {
                return const SizedBox.shrink();
              }
              final item = state.data.logs[i];
              return CustomChoiceChip.green(
                label: getDateOnly(item.date).isToday
                    ? '${getDateOnly(item.date).shortWeekdayWithMonth} - ${LocalizedTexts.today.tr().capitalize()}'
                    : getDateOnly(item.date).shortWeekdayWithMonth,
                selected: item == widget.controller.selectedValueNotifier.value,
                onSelected: _onSelected,
                value: item,
                action: CustomText.w400(
                  widget.controller.getTimes(item),
                  textAlign: TextAlign.start,
                  style: context.textTheme.bodySmall,
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 8.0),
            itemCount: state.data.logs.length,
          );
        });
  }
}
