import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';
import 'package:loopcare_frontend/features/preferences/presentation/preferences_overview/widgets/preferences_list.dart';
import 'package:loopcare_frontend/features/preferences/presentation/preferences_overview/survey_item_image_clipper.dart';

class PreferencesListItem extends StatelessWidget {
  final Pref item;
  final void Function(Pref item) onTapHandler;

  const PreferencesListItem({
    Key? key,
    required this.item,
    required this.onTapHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Material(
        child: InkWell(
          onTap: _onItemPressed,
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
                ClipPath(
                  clipper: SurveyItemImageClipper(),
                  child: Container(
                    width: 98,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12)),
                      image: DecorationImage(
                        image: item.imagePath,
                        fit: BoxFit.cover,
                      ),
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

  void _onItemPressed() {
    onTapHandler(item);
  }
}
