import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/relation.dart';

class BuddyRelationChips extends StatefulWidget {
  const BuddyRelationChips({super.key});

  @override
  State<BuddyRelationChips> createState() => _BuddyRelationChipsState();
}

class _BuddyRelationChipsState extends State<BuddyRelationChips> {
  Relation? _selectedValue;

  void _onSelected(Relation value) => setState(() {
        context.read<BuddyBloc>().add(BuddyEvent.relation(relation: value.name));
        _selectedValue = value;
      });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int i) {
        final item = Relation.values[i];

        return CustomChoiceChip.coral(
          label: item.label,
          selected: item == _selectedValue,
          onSelected: _onSelected,
          value: item,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
      itemCount: Relation.values.length,
    );
  }
}
