import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/preferences/presentation/preferences_overview/widgets/preferences_list.dart';
import 'package:loopcare_frontend/features/preferences/presentation/preferences_overview/survey_item_image_clipper.dart';

class PreferencesListItem extends StatelessWidget {
  final Pref item;
  final String routePath;
  final Color imageOverlayColor;

  const PreferencesListItem({
    Key? key,
    required this.item,
    required this.routePath,
    required this.imageOverlayColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Material(
        child: InkWell(
          onTap: () => _onItemPressed(context),
          child: Ink(
            height: 96.0,
            padding: const EdgeInsets.only(right: 26.0),
            decoration: BoxDecoration(
              color: item.isCompleted
                  ? AppColors.white.withOpacity(0.0)
                  : AppColors.white,
              border: Border.all(
                width: 1,
                color: AppColors.yellowLight,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 98,
                  child: ClipPath(
                    clipper: SurveyItemImageClipper(),
                    child: Image(
                      width: double.infinity,
                      height: double.infinity,
                      image: item.imagePath,
                      fit: BoxFit.cover,
                      color: imageOverlayColor,
                      colorBlendMode: BlendMode.multiply,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          item.completionTime,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                Hexagon(
                  width: 60,
                  height: 60,
                  borderRadius: 15.0,
                  innerWidget: Container(
                    decoration: BoxDecoration(
                      color: item.isCompleted
                          ? AppColors.yellowLight
                          : AppColors.bgGreen,
                      image: DecorationImage(
                        image: item.isCompleted
                            ? AppIcons.checkmark
                            : AppIcons.arrow,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onItemPressed(BuildContext context) {
    context.router.pushNamed(routePath);
  }
}
