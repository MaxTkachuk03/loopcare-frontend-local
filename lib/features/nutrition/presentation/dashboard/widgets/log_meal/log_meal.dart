import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/nutrition/domain/core/name_label.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Image(
                image: AppIcons.dashbordLogMeals,
              ),
              const SizedBox(width: 24.0),
              // TODO get data from the user bloc
              Text(
                LocalizedTexts.logYourMeals.translation,
                style: Theme.of(context).textTheme.headline5!.copyWith(
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
    );
  }
}
