import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SupportGroup extends StatelessWidget {
  final bool isEditable;

  const SupportGroup({
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
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: const BoxDecoration(
                color: AppColors.blueAppBar,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: Text(
                'comming up'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Image(
                        image: AppIcons.supportGroup,
                      ),
                      const SizedBox(width: 24.0),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocalizedTexts.supportGroup.translation,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    fontFamily: ThemeConstants.bitterFontFamily,
                                  ),
                            ),
                            const SizedBox(height: 3.0),
                            // TODO get text from the server
                            Text(
                              'Eating Behaviour & Stressful Situations',
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Thursday from 21:00 to 22:00',
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
                const ImageIcon(
                  AppIcons.arrow,
                  color: AppColors.greyLabel,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
