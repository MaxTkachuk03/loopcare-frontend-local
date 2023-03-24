import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';

class FoodItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String serving;
  final String nutritionValue;

  const FoodItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.serving,
    required this.nutritionValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: _onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: AppColors.yellowLight),
            ),
            color: AppColors.white,
          ),
          child: Table(columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(6),
            1: FlexColumnWidth(2),
            2: IntrinsicColumnWidth(),
          }, children: [
            TableRow(children: [
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
                      onPressed: _onDeletePressed,
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
                          title,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Text(
                          subtitle,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: AppColors.greyLabel,
                                overflow: TextOverflow.ellipsis,
                              ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
              Text(
                serving,
                style: Theme.of(context).textTheme.caption?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(nutritionValue,
                      style: Theme.of(context).textTheme.caption),
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
            ])
          ]),
        ),
      ),
    );
  }

  void _onTap() {}

  void _onDeletePressed() {}
}
