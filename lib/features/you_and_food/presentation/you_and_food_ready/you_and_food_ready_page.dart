import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/success_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/editable_item.dart';

class YouAndFoodReadyPage extends StatelessWidget {
  const YouAndFoodReadyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizedTexts.youAndFood.tr()),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 40.0),
                    SuccessContainer(
                      title: LocalizedTexts.ready.tr(),
                      contentPadding: const EdgeInsets.all(0),
                      content: Column(
                        children: [
                          EditableItem(
                            title: LocalizedTexts.iDoNotEatOrDrink.tr(),
                          ),
                          EditableItem(
                            title: LocalizedTexts.iPreferToEatMeatOrFish.tr(),
                            subtitle: 'Pork, Alcohol',
                          ),
                          EditableItem(
                            title: LocalizedTexts.iAmAllergicTo.tr(),
                            subtitle: 'Pork, Alcohol, Pork, Alcohol, Pork, Alcohol, Pork, Alcohol, Pork, Alcohol, Pork, Alcohol Pork, Alcohol Pork, Alcohol',
                          ),
                          EditableItem(
                            title: LocalizedTexts.iDoNotLike.tr(),
                            subtitle: 'Pork, Alcohol',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => _onBackPressed(context),
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.copyWith(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.orangeDark),
                          ),
                      child: Text(LocalizedTexts.backToTheOverview.tr()),
                    ),
                    const SizedBox(height: 30.0),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onBackPressed(BuildContext context) {
    context.router.popUntilRouteWithName(PreferencesOverviewRoute.name);
  }
}
