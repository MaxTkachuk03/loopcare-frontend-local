import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_values_types/nutrition_values_types.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/widgets/meal_portions_input/meal_portions_input.dart';

class NutritionValuesBlock extends StatelessWidget {
  final int numberOfPortions;
  final NutritionValuesTypes selectedNutritionType;
  final List<NutritionItem> nutritionValuesList;
  final void Function(NutritionValuesTypes item) onNutritionFactSelect;
  final TextEditingController? portionsController;
  final bool? isPortionsEditable;
  final FocusNode? portionsFocusNode;

  const NutritionValuesBlock({
    Key? key,
    required this.numberOfPortions,
    required this.selectedNutritionType,
    required this.nutritionValuesList,
    required this.onNutritionFactSelect,
    this.portionsController,
    this.isPortionsEditable,
    this.portionsFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nutritionItem = nutritionValuesList
        .firstWhere((element) => element.key == selectedNutritionType.name);

    return Container(
      decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(
              bottom: BorderSide(
            width: 1,
            color: AppColors.yellowLight,
          ))),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocalizedTexts.ingredientsBasedOn.translation.toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12.0,
                    ),
              ),
              if (isPortionsEditable != null)
                MealPortionsInput(
                  controller: portionsController,
                  focusNode: portionsFocusNode,
                ),
              if (isPortionsEditable == null)
                Text(
                  LocalizedTexts.portionMeal.translateWithNamedArgs(
                      {'numberOfPortion': '$numberOfPortions'}),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
            ],
          ),
          InkWell(
            onTap: () => _onNutritionFactTap(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${LocalizedTexts.total.translation.toUpperCase()} ${selectedNutritionType.name.toUpperCase()}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12.0,
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${nutritionItem.value} ${selectedNutritionType.unitLabel}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    const SizedBox(
                      width: 12,
                      height: 16,
                      child: ImageIcon(
                        AppIcons.arrow,
                        color: AppColors.darkGreen,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _onNutritionFactTap(BuildContext context) {
    ModalBottomSheet.nutrientFactsDialog(
      context: context,
      list: nutritionValuesList,
      onSelect: onNutritionFactSelect,
    );
  }
}
