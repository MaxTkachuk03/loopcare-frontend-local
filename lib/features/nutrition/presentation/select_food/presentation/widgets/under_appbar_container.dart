import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/nutrition_field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/underlined_tab_bar.dart';

class UnderAppBarContainer extends StatelessWidget {
  const UnderAppBarContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blueAppBar,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(
            height: 8.0,
          ),
          SizedBox(
            height: 38,
            child: NutritionField(
              readOnly: true,
              hintText: LocalizedTexts.searchYourFood.tr(),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.blueDark,
              ),
            ),
          ),
          const SizedBox(
            height: 18.0,
          ),
          SizedBox(
            height: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: UnderlinedTabBar(
                    tabs: [
                      Tab(
                        text: LocalizedTexts.myFavorites.tr(),
                      ),
                      Tab(
                        text: LocalizedTexts.myDishes.tr(),
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const ImageIcon(AppIcons.scan),
                  label: Text(LocalizedTexts.scan.tr()),
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      minimumSize: const Size(0, 0),
                      foregroundColor: AppColors.white,
                      textStyle: Theme.of(context).textTheme.bodyText2,
                      alignment: Alignment.bottomCenter),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
        ],
      ),
    );
  }
}
