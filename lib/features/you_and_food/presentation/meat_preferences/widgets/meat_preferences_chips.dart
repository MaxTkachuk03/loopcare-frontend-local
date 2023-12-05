import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
// import 'package:loopcare_frontend/features/you_and_food/application/dto/food_preference.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';

// TODO descoped for now, API changed, so in future changes will be required to make it works
class MeatPreferencesChips extends StatefulWidget {
  const MeatPreferencesChips({super.key});

  @override
  State<MeatPreferencesChips> createState() => _MeatPreferencesChipsState();
}

class _MeatPreferencesChipsState extends State<MeatPreferencesChips> {
  @override
  void initState() {
    context.read<YouAndFoodBloc>().add(const YouAndFoodEvent.foodPrefsPeriods());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO just a placeholder to get rid of errors
    return const Text('sdf');
    // return BlocBuilder<YouAndFoodBloc, YouAndFoodState>(builder: (BuildContext context, state) {
    //   final selectedPeriod = state.selectedPeriod;
    //   return Column(
    //     children: state.foodPeriods
    //         .map((element) => Column(
    //               children: [
    //                 AppChoiceChip(
    //                   label: element.name,
    //                   selected: selectedPeriod != null && selectedPeriod == element,
    //                   value: element.id,
    //                   onSelected: _onSelected,
    //                   textAlign: TextAlign.left,
    //                 ),
    //                 const SizedBox(height: 8.0)
    //               ],
    //             ))
    //         .toList(),
    //   );
    // });
  }

  // void _onSelected(FoodPreference value) {
  //   context.read<YouAndFoodBloc>().add(YouAndFoodEvent.setPeriod(value));
  // }
}
