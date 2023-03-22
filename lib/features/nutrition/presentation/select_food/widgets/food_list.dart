import 'dart:math';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category.dart';
import 'package:loopcare_frontend/features/nutrition/domain/select_serving/meal_category_filter.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/select_food/widgets/clickable_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/domain/nutrition_instructions/dialog_filter.dart';

class FoodList extends StatelessWidget {
  final String title;
  final List<dynamic> list; // TODO: change type

  const FoodList({
    Key? key,
    required this.title,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainContainer(
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
                  width: 24.0,
                  height: 24.0,
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
        ),
        Expanded(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return const ClickableListItem(
                title: 'Test',
                description: 'Test2',
              );
            },
          ),
        ),
        // TODO: add check if there are selected items
        // const FooterOverlay(),
      ],
    );
  }

  void _onShowMy(BuildContext context) {
    final List<MealCategoryFilter> filters = MealCategory.values.map((v) {
      return MealCategoryFilter(name: v.name, selected: false);
    }).toList();

    // ModalBottomSheet.filterDialog(
    //   context: context,
    //   title: LocalizedTexts.showMy.tr(),
    //   subtitle: 'Chicken roasted or grilled serving: 1 piece (150 g)',
    //   onConfirmed: () {},
    //   list: filters,
    //   onChanged: (bool value, String name) {},
    // );
  }
}
