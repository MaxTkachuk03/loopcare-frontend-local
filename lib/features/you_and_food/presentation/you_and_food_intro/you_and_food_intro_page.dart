import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/survey_image_clipper.dart';

class YouAndFoodIntroPage extends StatefulWidget {
  const YouAndFoodIntroPage({Key? key}) : super(key: key);

  @override
  State<YouAndFoodIntroPage> createState() => _YouAndFoodIntroPageState();
}

class _YouAndFoodIntroPageState extends State<YouAndFoodIntroPage> {
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
                    color: AppColors.blueLight.withOpacity(0.8),
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
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            LocalizedTexts.youAndFood.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(
                                  fontFamily: ThemeConstants.bitterFontFamily,
                                  color: AppColors.blueDark,
                                ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            LocalizedTexts.youAndFoodDesc.tr(),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 36.0,
                          ),
                          BulletListItem(
                            text: Text(
                              LocalizedTexts.youAndFoodItemOne.tr(),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            bulletSize: 18.0,
                          ),
                          BulletListItem(
                            text: Text(
                              LocalizedTexts.youAndFoodItemTwo.tr(),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            bulletSize: 18.0,
                          ),
                          BulletListItem(
                            text: Text(
                              LocalizedTexts.youAndFoodItemThree.tr(),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            bulletSize: 18.0,
                          ),
                          BulletListItem(
                            text: Text(
                              LocalizedTexts.youAndFoodItemFour.tr(),
                              style: Theme.of(context).textTheme.bodyText1,
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
                child: ElevatedButton(
                  onPressed: _onStart,
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.orangeDark),
                      ),
                  child: Text(LocalizedTexts.start.tr()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onStart() {}
}
