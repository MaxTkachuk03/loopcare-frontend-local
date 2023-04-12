import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_item/nutrition_item.dart';

class NutritionValuesBlock extends StatelessWidget {
  final int numberOfPortions;
  final double nutritionValue;
  final NutritionItem selectedNutritionItem;
  final List<NutritionItem> nutritionValuesList;
  final void Function(NutritionItem item) onNutritionFactSelect;

  const NutritionValuesBlock({
    Key? key,
    required this.numberOfPortions,
    required this.nutritionValue,
    required this.selectedNutritionItem,
    required this.nutritionValuesList,
    required this.onNutritionFactSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontSize: 12.0,
                    ),
              ),
              Text(
                LocalizedTexts.portionMeal.translateWithNamedArgs(
                    {'numberOfPortion': '$numberOfPortions'}),
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${LocalizedTexts.total.translation.toUpperCase()} ${selectedNutritionItem.name.toUpperCase()}',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontSize: 12.0,
                    ),
              ),
              InkWell(
                onTap: () => _onNutritionFactTap(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '$nutritionValue ${selectedNutritionItem.unitLabel}',
                      style: Theme.of(context).textTheme.caption?.copyWith(
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
              ),
            ],
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
