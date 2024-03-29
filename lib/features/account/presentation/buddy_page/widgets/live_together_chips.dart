import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/yes_no_answer.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_bloc.dart';

class LiveTogetherChips extends StatefulWidget {
  const LiveTogetherChips({super.key});

  @override
  State<LiveTogetherChips> createState() => _LiveTogetherChipsState();
}

class _LiveTogetherChipsState extends State<LiveTogetherChips> {
  YesNoAnswer? _selectedValue;

  void _onSelected(YesNoAnswer value) => setState(() {
        context.read<BuddyBloc>().add(BuddyEvent.liveTogether(liveTogether: value == YesNoAnswer.yes));
        _selectedValue = value;
      });

  @override
  void initState() {
    super.initState();
    final hasAnswer = context.read<BuddyBloc>().state.data.liveTogether;
    if (hasAnswer != null) {
      _selectedValue = hasAnswer ? YesNoAnswer.yes : YesNoAnswer.no;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int i) {
        final item = YesNoAnswer.values[i];

        return CustomChoiceChip.coral(
          label: item.label,
          selected: item == _selectedValue,
          onSelected: _onSelected,
          value: item,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
      itemCount: YesNoAnswer.values.length,
    );
  }
}
