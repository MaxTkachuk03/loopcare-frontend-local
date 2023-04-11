import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meal_item.dart';

class FoodItem extends StatelessWidget {
  final MealItem foodItem;
  final Function(BuildContext, int?) onDeletePressed;

  const FoodItem({
    super.key,
    required this.foodItem,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: _onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.yellowLight),
            ),
            color: AppColors.white,
          ),
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(6),
              1: FlexColumnWidth(2),
              2: IntrinsicColumnWidth(),
            },
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: IconButton(
                            splashRadius: 20,
                            padding: EdgeInsets.zero,
                            iconSize: 22,
                            onPressed: () => onDeletePressed(
                              context,
                              foodItem.id,
                            ),
                            icon: const Icon(
                              Icons.close,
                              color: AppColors.darkGreen,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Hexagon(
                          width: 20,
                          height: 20,
                          borderRadius: 10,
                          innerWidget: Container(
                            color: AppColors.red,
                          ),
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                foodItem.name,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis),
                              ),
                              Text(
                                foodItem.description,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppColors.greyLabel,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    foodItem.serving.servingDescription,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(foodItem.serving.calories.toString(),
                          style: Theme.of(context).textTheme.bodySmall),
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onTap() {}
}
