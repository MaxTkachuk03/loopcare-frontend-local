import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class Diary extends StatelessWidget {
  final bool isEditable;

  const Diary({
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Image(
                    image: AppIcons.diaryEmotionGreat,
                  ),
                  const SizedBox(width: 24.0),
                  Text(
                    LocalizedTexts.diary.translation,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontFamily: ThemeConstants.bitterFontFamily,
                        ),
                  ),
                ],
              ),
              const ImageIcon(
                AppIcons.arrow,
                color: AppColors.greyLabel,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          const Divider(color: AppColors.yellowLight),
          // TODO will be text from the server
          Text(
            '“Today felt great. Several friends visited and they all brought presents, most special was a...”',
            style: Theme.of(context).textTheme.caption!.copyWith(
                  fontStyle: FontStyle.italic,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
