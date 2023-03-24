import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class MealPortions extends StatelessWidget {
  const MealPortions({Key? key}) : super(key: key);

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
                LocalizedTexts.portionMeal
                    .translateWithNamedArgs({'numberOfPortion': '4'}),
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
                LocalizedTexts.totalEnergy.translation.toUpperCase(),
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
                      '560 kcal',
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
      list: [1, 2],
      onSelect: (item) {
      },
    );
  }
}
