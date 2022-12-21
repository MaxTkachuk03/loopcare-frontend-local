import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/small_outlined_button.dart';

class JoinUsStep extends StatelessWidget {
  final String title;
  final String subtitle;
  final String markLetter;

  const JoinUsStep({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.markLetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 24.0,
        right: 34.0,
        bottom: 34.0,
        left: 22.0,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 54,
            height: 54,
            child: ClipPolygon(
              sides: 6,
              borderRadius: 15.0,
              rotate: 90.0,
              child: Container(
                color: AppColors.blueDark,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      markLetter,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 18.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 8.0,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.bgGreen,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: Text(
                        LocalizedTexts.testDuration.tr(),
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    SmallOutlinedButton(
                      text: LocalizedTexts.moreInfo.tr(),
                      onPressed: _onMoreInfoPressed,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onMoreInfoPressed() {}
}
