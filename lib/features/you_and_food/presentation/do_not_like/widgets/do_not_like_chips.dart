import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/features/you_and_food/application/dto/food_preference.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';

class DoYouLikeChips extends StatefulWidget {
  const DoYouLikeChips({super.key});

  @override
  State<DoYouLikeChips> createState() => _DoYouLikeChipsState();
}

class _DoYouLikeChipsState extends State<DoYouLikeChips> {
  @override
  void initState() {
    context.read<YouAndFoodBloc>().add(const YouAndFoodEvent.foodPrefsDislikes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth / 2 - 5;
        return BlocBuilder<YouAndFoodBloc, YouAndFoodState>(
          builder: (BuildContext context, state) {
            final selectedDislike = state.selectedDislike;

            return Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: state.foodDislikes
                  .map(
                    (e) => SizedBox(
                      width: width,
                      child: CustomChoiceChip.coral(
                        label: e.name,
                        selected: selectedDislike.contains(e),
                        value: e,
                        onSelected: _onSelected,
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        );
      },
    );
  }

  void _onSelected(FoodPreference value) {
    context.read<YouAndFoodBloc>().add(YouAndFoodEvent.setDislike(value));
  }
}
