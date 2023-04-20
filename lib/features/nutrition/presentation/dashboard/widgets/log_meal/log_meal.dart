import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/domain/calorie_density_scale_layout.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/calorie_density_scale/calorie_density_scale.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/nutrition/domain/core/name_label.dart';
import 'package:loopcare_frontend/features/nutrition/domain/meal_category/logged_category_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/dashboard/widgets/log_meal/logged_list.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/string_extensions.dart';

class LogMeal extends StatelessWidget {
  final bool isEditable;

  const LogMeal({
    Key? key,
    required this.isEditable,
  }) : super(key: key);

  void onPressHandler(BuildContext context) {
    ModalBottomSheet.selectAMealDialog(
      context: context,
      list: MealCategory.values
          .map((e) => NameLabel(name: e.name, label: e.label ?? ''))
          .toList(),
      onSelect: (NameLabel item) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Image(
                    image: AppIcons.dashbordLogMeals,
                  ),
                  const SizedBox(width: 24.0),
                  Text(
                    LocalizedTexts.logYourMeals.translation,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontFamily: ThemeConstants.bitterFontFamily,
                        ),
                  ),
                ],
              ),
              Hexagon(
                width: 54,
                height: 54,
                borderRadius: 16,
                innerWidget: Container(
                  color: AppColors.bgGreen,
                  child: IconButton(
                    icon: ImageIcon(
                      isEditable ? AppIcons.edit : AppIcons.plus,
                      color: AppColors.darkGreen,
                      size: 18,
                    ),
                    onPressed: () => onPressHandler(context),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          const Divider(color: AppColors.yellowLight),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocalizedTexts.logged.translation.toUpperCase(),
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                fontSize: ThemeConstants.fontSize12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.greyLabel,
                              ),
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        const ImageIcon(
                          AppIcons.arrow,
                          color: AppColors.greyLabel,
                          size: 10,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    LoggedList(
                      list: MealCategory.values
                          .map(
                            (e) => LoggedCategoryItem(
                              label:
                                  e.shortLabel?.capitalizeOnlyFirstLetter() ??
                                      '',
                              isFilled: Random().nextBool(),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocalizedTexts.calorieDensity.translation
                              .toUpperCase(),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: ThemeConstants.fontSize12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.greyLabel,
                                  ),
                        ),
                        const SizedBox(width: 4.0),
                        const ImageIcon(
                          AppIcons.arrow,
                          color: AppColors.greyLabel,
                          size: 10,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Perfect',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: ThemeConstants.fontSize14,
                            color: AppColors.darkGreen,
                          ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 22,
                      child: CalorieDensityScale(
                        density: 1.1,
                        layout: CalorieDensityScaleLayout.horizontal,
                        separatorColor: AppColors.bgGreen,
                        separatorSize: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
