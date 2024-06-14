import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/features/smart_goals/application/cancel_goal_reason.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_bloc.dart';

class WeeklyGoalReasonChips extends StatefulWidget {
  const WeeklyGoalReasonChips({super.key});

  @override
  State<WeeklyGoalReasonChips> createState() => _WeeklyGoalReasonChipsState();
}

class _WeeklyGoalReasonChipsState extends State<WeeklyGoalReasonChips> {
  CancelGoalReason? _selectedValue;

  void _onSelected(CancelGoalReason value) => setState(() {
        context.read<SmartGoalsBloc>().add(SmartGoalsEvent.selectCancelGoalReason(reason: value));
        _selectedValue = value;
      });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int i) {
        final item = CancelGoalReason.values[i];

        return CustomChoiceChip.green(
          label: item.label,
          selected: item == _selectedValue,
          onSelected: _onSelected,
          value: item,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
      itemCount: CancelGoalReason.values.length,
    );
  }
}
