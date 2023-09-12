import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/progress_bar.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/preferences/widgets/physical_activities_image_header.dart';

class PhysicalActivitiesPreferencesPage extends StatefulWidget {
  const PhysicalActivitiesPreferencesPage({Key? key}) : super(key: key);

  @override
  State<PhysicalActivitiesPreferencesPage> createState() => _PhysicalActivitiesPreferencesPageState();
}

class _PhysicalActivitiesPreferencesPageState extends State<PhysicalActivitiesPreferencesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Column(
          children: [
            Text(
              LocalizedTexts.physicalActivitiesPreferences.translation,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              LocalizedTexts.introduction.translation,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const ProgressBar(
                    progress: 33,
                    backgroundColor: AppColors.white,
                  ),
                  const PhysicalActivitiesImageHeader(),
                  const SizedBox(height: 30.0),
                  MainContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocalizedTexts.physicalActivitiesPreferences.tr(),
                              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                    fontFamily: ThemeConstants.bitterFontFamily,
                                    color: AppColors.blueDark,
                                  ),
                            ),
                            const SizedBox(height: 32.0),
                            Text(
                              LocalizedTexts.physicalActivitiesPreferencesDesc.tr(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 16.0),
                            BulletListItem(
                              text: Text(
                                LocalizedTexts.physicalActivitiesPreferencesItemOne.tr(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              bulletSize: 18.0,
                            ),
                            BulletListItem(
                              text: Text(
                                LocalizedTexts.physicalActivitiesPreferencesItemTwo.tr(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              bulletSize: 18.0,
                            ),
                            BulletListItem(
                              text: Text(
                                LocalizedTexts.physicalActivitiesPreferencesItemThree.tr(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              bulletSize: 18.0,
                            ),
                            const SizedBox(height: 16.0),
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
      ),
    );
  }

  void _onStart(BuildContext context) {
    context.router.pushNamed(AppRoutes.physicalActivitiesFrequency);
  }
}
