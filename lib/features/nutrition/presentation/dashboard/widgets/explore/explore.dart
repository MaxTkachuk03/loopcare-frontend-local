import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class Explore extends StatelessWidget {
  final bool isEditable;

  const Explore({
    Key? key,
    required this.isEditable,
  }) : super(key: key);

  void onPressHandler(BuildContext context) {
    // TODO do logic depends on editable weight block state
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
                  const SizedBox(
                    width: 55.0,
                    child: Image(
                      image: AppIcons.dashbordExplore,
                    ),
                  ),
                  const SizedBox(width: 24.0),
                  Text(
                    LocalizedTexts.explore.translation,
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
          const SizedBox(height: 16.0),
          // TODO will be text from the server
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Image(
                      image: AppImages.exploreFaces,
                      width: 100,
                    ),
                    const SizedBox(width: 16.0),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "mind".toUpperCase(),
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      fontSize: 14.0,
                                      color: AppColors.orangeDark,
                                    ),
                          ),
                          Text(
                            'How loved ones help',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              AppIcons.clock,
                              const SizedBox(width: 8.0),
                              Text(
                                '3m 59s',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          Text(
                            'Before friday 17 March',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontStyle: FontStyle.italic,
                                      color: const Color(0xFF919B8C),
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
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
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Image(
                      image: AppImages.exploreFaces,
                      width: 100,
                    ),
                    const SizedBox(width: 16.0),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "general".toUpperCase(),
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      fontSize: 14.0,
                                      color: AppColors.orangeDark,
                                    ),
                          ),
                          Text(
                            'Yo-yo effect',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              AppIcons.clock,
                              const SizedBox(width: 8.0),
                              Text(
                                '4m 21s',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          Text(
                            'Before friday 17 March',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontStyle: FontStyle.italic,
                                      color: const Color(0xFF919B8C),
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
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
