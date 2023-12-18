import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/survey_image_clipper.dart';

class HouseholdAndHabitsIntroPage extends StatefulWidget {
  const HouseholdAndHabitsIntroPage({super.key});

  @override
  State<HouseholdAndHabitsIntroPage> createState() => _HouseholdAndHabitsIntroPageState();
}

class _HouseholdAndHabitsIntroPageState extends State<HouseholdAndHabitsIntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: ScrollableContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ClipPath(
                  clipper: SurveyImageClipper(),
                  child: Image(
                    width: double.infinity,
                    image: AppImages.youAndFoodIntro,
                    fit: BoxFit.cover,
                    color: AppColors.purple.withOpacity(0.8),
                    colorBlendMode: BlendMode.multiply,
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                MainContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocalizedTexts.survey.tr().toUpperCase(),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            LocalizedTexts.householdAndEatingHabits.tr(),
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontFamily: ThemeConstants.bitterFontFamily,
                                  color: AppColors.blueDark,
                                ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            LocalizedTexts.householdIntroDesc.tr(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 36.0,
                          ),
                          BulletListItem(
                            text: Text(
                              LocalizedTexts.householdIntroTextOne.tr(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            bulletSize: 18.0,
                          ),
                          BulletListItem(
                            text: Text(
                              LocalizedTexts.householdIntroTextTwo.tr(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            bulletSize: 18.0,
                          ),
                          BulletListItem(
                            text: Text(
                              LocalizedTexts.householdIntroTextThree.tr(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            bulletSize: 18.0,
                          ),
                          BulletListItem(
                            text: Text(
                              LocalizedTexts.householdIntroTextFour.tr(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            bulletSize: 18.0,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SafeArea(
              top: false,
              child: MainContainer(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 53.0),
                  child: ElevatedButton(
                    onPressed: () => _onStart(context),
                    style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                          backgroundColor: MaterialStateProperty.all(AppColors.orangeDark),
                        ),
                    child: Text(LocalizedTexts.start.tr()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onStart(BuildContext context) {
    context.router.pushNamed(AppRoutes.shareMealWith);
  }
}
