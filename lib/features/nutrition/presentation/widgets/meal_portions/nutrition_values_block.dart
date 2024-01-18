import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
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
    super.key,
    required this.numberOfPortions,
    required this.selectedNutritionType,
    required this.nutritionValuesList,
    required this.onNutritionFactSelect,
    this.portionsController,
    this.isPortionsEditable,
    this.portionsFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    if (nutritionValuesList.isEmpty) {
      return const SizedBox.shrink();
    }
    final nutritionItem = nutritionValuesList.firstWhere((element) => element.key == selectedNutritionType.name);
    final totalValue = (numberOfPortions * nutritionItem.value).toStringAsFixed(2);

    return Container(
      decoration: const BoxDecoration(
          color: AppColors.greenLightest,
          border: Border(
              bottom: BorderSide(
            width: 1,
            color: AppColors.greenLight,
          ))),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.w400(
                LocalizedTexts.ingredientsBasedOn.translation.toUpperCase(),
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: ThemeConstants.fontSize12,
                ),
              ),
              if (isPortionsEditable != null)
                MealPortionsInput(
                  controller: portionsController,
                  focusNode: portionsFocusNode,
                ),
              if (isPortionsEditable == null)
                CustomText.w600(
                  LocalizedTexts.portionMeal.translateWithNamedArgs({'numberOfPortion': '$numberOfPortions'}),
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: ThemeConstants.fontSize12,
                  ),
                ),
            ],
          ),
          InkWell(
            onTap: () => _onNutritionFactTap(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomText.w400(
                  '${LocalizedTexts.total.translation.toUpperCase()} ${selectedNutritionType.name.toUpperCase()}',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: ThemeConstants.fontSize12,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText.w600(
                      '$totalValue ${selectedNutritionType.unitLabel}',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: ThemeConstants.fontSize12,
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    const SizedBox(
                      width: 14,
                      height: 16,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.blueDarker,
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
