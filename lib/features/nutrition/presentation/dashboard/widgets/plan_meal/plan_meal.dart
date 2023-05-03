import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';

class PlanMeal extends StatelessWidget {
  final bool isEditable;

  const PlanMeal({
    Key? key,
    required this.isEditable,
  }) : super(key: key);

  void onPressHandler(BuildContext context) {
    // TODO do logic depends on editable weight block state
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 24.0,
        right: 16.0,
        left: 16.0,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
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
                    image: AppIcons.dashbordPlanMeals,
                  ),
                  const SizedBox(width: 24.0),
                  Text(
                    LocalizedTexts.planYourMeals.translation,
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
          const SizedBox(height: 8.0),
          const Divider(color: AppColors.yellowLight),
          // TODO will be text from the server
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's lunch".toUpperCase(),
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 12.0,
                          color: AppColors.greyLabel,
                        ),
                  ),
                  Text(
                    'Tomato salat, milk, bowl of rice',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 12.0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              const Image(
                image: AppIcons.arrow,
                color: AppColors.greyLabel,
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's dinner".toUpperCase(),
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 12.0,
                          color: AppColors.greyLabel,
                        ),
                  ),
                  Text(
                    'Pasta, Broccoli, Chicken Marsala',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontSize: 12.0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              const Image(
                image: AppIcons.arrow,
                color: AppColors.greyLabel,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
