import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
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
            child: InkWell(
              onTap: () => context.router.pushNamed(AppRoutes.search),
              child: IgnorePointer(
                child: NutritionField(
                  readOnly: true,
                  hintText: LocalizedTexts.searchHint.translation,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.blueDark,
                  ),
                ),
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
                      Tab(text: LocalizedTexts.myFavorites.translation),
                      Tab(text: LocalizedTexts.myDishes.translation),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    context.router.pushNamed(AppRoutes.barcodeScanner);
                  },
                  icon: const ImageIcon(AppIcons.scan),
                  label: Text(LocalizedTexts.scan.translation),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    minimumSize: const Size(0, 0),
                    foregroundColor: AppColors.white,
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    alignment: Alignment.bottomCenter,
                  ),
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
