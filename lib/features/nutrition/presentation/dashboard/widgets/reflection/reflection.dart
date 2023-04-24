import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class Reflection extends StatelessWidget {
  final bool isEditable;

  const Reflection({
    Key? key,
    required this.isEditable,
  }) : super(key: key);

  void onPressHandler(BuildContext context) {
    // TODO do logic depends on editable weight block state
    context.router.pushNamed(AppRoutes.selectFood);
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
          Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(
                image: AppIcons.dashbordReflectionDone,
              ),
              const SizedBox(width: 24.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocalizedTexts.reflection.translation,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontFamily: ThemeConstants.bitterFontFamily,
                        ),
                  ),
                  const SizedBox(height: 3.0),
                  // TODO get text from the server
                  AutoSizeText(
                    'Looking back at past 2 weeks',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    maxLines: 1,
                  ),
                  Text(
                    'Completed',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF919B8C),
                        ),
                  ),
                ],
              ),
            ],
          ),
          const ImageIcon(
            AppIcons.arrow,
            color: AppColors.greyLabel,
          ),
        ],
      ),
    );
  }
}
