import 'dart:math';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category_filter.dart';

class ListFilters extends StatelessWidget {
  final String title;
  final List<MealCategoryFilter> mealsList;
  final Function(List<MealCategoryFilter> updatedFiltersList) onConfirmed;

  const ListFilters({
    Key? key,
    required this.title,
    required this.mealsList,
    required this.onConfirmed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Hexagon(
              width: 28.0,
              height: 28.0,
              borderRadius: 3,
              innerWidget: Container(
                color: AppColors.yellowLight,
                child: Transform.rotate(
                  angle: 90 * pi / 180,
                  child: IconButton(
                    icon: const ImageIcon(
                      AppIcons.arrow,
                      color: AppColors.darkGreen,
                    ),
                    onPressed: () => _onShowMy(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onShowMy(BuildContext context) {
    ModalBottomSheet.filterDialog(
      context: context,
      title: LocalizedTexts.showMy.translation,
      onConfirmed: onConfirmed,
      list: mealsList,
    );
  }
}
