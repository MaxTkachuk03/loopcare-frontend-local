import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/food_item_serving.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/food_item_servings_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/serving_input_field/serving_input_field.dart';

class SelectedListItem extends StatelessWidget {
  final FoodItemServing item;
  final TextEditingController inputController;
  final void Function(FoodItemServing item) onPressed;

  const SelectedListItem({
    Key? key,
    required this.item,
    required this.onPressed,
    required this.inputController,
  }) : super(key: key);

  void _onAmountChange(BuildContext context, String value) {
    final String amount = value.isEmpty ? '0' : value;

    context
        .read<FoodItemServingsBloc>()
        .add(FoodItemServingsEvent.setSelectedServingAmount(amount));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(item),
      child: Container(
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 14.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  const Icon(
                    Icons.check,
                    color: AppColors.blueDark,
                  ),
                  const SizedBox(width: 8.0),
                  Flexible(
                    child: AutoSizeText(
                      maxLines: 2,
                      item.servingLabel,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            color: AppColors.blueDark,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                SizedBox(
                  width: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(LocalizedTexts.amount.translation,
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        fontSize: 12.0,
                                      )),
                          Text(LocalizedTexts.calories.translation,
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        fontSize: 12.0,
                                      )),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ServingInputField(
                            controller: inputController,
                            fillColor: AppColors.bgGreen,
                            onChange: (value) =>
                                _onAmountChange(context, value),
                          ),
                          BlocBuilder<FoodItemServingsBloc,
                                  FoodItemServingsState>(
                              builder: (BuildContext context, state) {
                            return Text(
                              '${state.selectedServingCalories}',
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.darkGreen,
                                      ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
