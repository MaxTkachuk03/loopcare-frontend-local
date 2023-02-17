import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';

class MeatPreferencesChips extends StatefulWidget {
  const MeatPreferencesChips({Key? key}) : super(key: key);

  @override
  State<MeatPreferencesChips> createState() => _MeatPreferencesChipsState();
}

class _MeatPreferencesChipsState extends State<MeatPreferencesChips> {
  @override
  void initState() {
    context
        .read<YouAndFoodBloc>()
        .add(const YouAndFoodEvent.foodPrefsPeriods());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<YouAndFoodBloc, YouAndFoodState>(
        builder: (BuildContext context, state) {
      final selectedPeriod = state.selectedPeriod;
      return Column(
        children: state.foodPeriods
            .map((element) => Column(
                  children: [
                    AppChoiceChip(
                      label: element.name,
                      selected: selectedPeriod != null &&
                          selectedPeriod == element.id,
                      value: element.id,
                      onSelected: _onSelected,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 8.0)
                  ],
                ))
            .toList(),
      );
    });
  }

  void _onSelected(int value) {
    context.read<YouAndFoodBloc>().add(YouAndFoodEvent.setPeriod(value));
  }
}
