import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/edit_food_preferences_page/edit_food_preferences_page.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/utils/get_label_by_stream_type.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/features/you_and_food/application/you_and_food_bloc.dart';

// TODO could be deleted, check requirements with Diana
@RoutePage()
class LessonCompleteFoodPreferencesPage extends StatefulWidget {
  final RiverModuleStreamType streamType;

  const LessonCompleteFoodPreferencesPage({super.key, required this.streamType});

  @override
  State<LessonCompleteFoodPreferencesPage> createState() =>
      _LessonCompleteFoodPreferencesPageState();
}

class _LessonCompleteFoodPreferencesPageState extends State<LessonCompleteFoodPreferencesPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = context.read<YouAndFoodBloc>().state;
    const AnalyticsEventService().logFoodPreferencesEvent(
      AnalyticsEvents.lessonCompleteFoodPreferencesScreen,
      state.selectedHatesNames,
      state.selectedAllergicNames,
      state.selectedDislikesNames,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: CustomScaffold(
        color: widget.streamType.lightestColor,
        appBar: CustomAppBar(
          backgroundColor: widget.streamType.regularColor,
          textTheme: widget.streamType.appBarTextTheme,
          title: LocalizedTexts.preferences.tr(),
          leading: CustomFilledIconButton.fromColor(color: widget.streamType.lighterColor),
        ),
        body: CustomSafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 8.0),
                      Container(
                          alignment: Alignment.center,
                          child: const Image(image: AppImages.foodPreferences)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getLabelByStreamType(widget.streamType),
                      const SizedBox(height: 18.0),
                      CustomText.bitter600(
                        LocalizedTexts.foodPreferences.tr(),
                        style: context.textTheme.displayLarge,
                      ),
                      const SizedBox(height: 18.0),
                      CustomText.w400(
                        LocalizedTexts.foodPreferencesDesc.tr(),
                        style: context.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 24.0),
                      BulletListItem(
                        text: CustomText.w400(
                          LocalizedTexts.foodPreferencesItemOne.tr(),
                          style: context.textTheme.bodyMedium,
                        ),
                        bulletSize: 18.0,
                      ),
                      BulletListItem(
                        text: CustomText.w400(
                          LocalizedTexts.foodPreferencesItemTwo.tr(),
                          style: context.textTheme.bodyMedium,
                        ),
                        bulletSize: 18.0,
                      ),
                      BulletListItem(
                        text: CustomText.w400(
                          LocalizedTexts.foodPreferencesItemThree.tr(),
                          style: context.textTheme.bodyMedium,
                        ),
                        bulletSize: 18.0,
                      ),
                      BulletListItem(
                        text: CustomText.w400(
                          LocalizedTexts.foodPreferencesItemFour.tr(),
                          style: context.textTheme.bodyMedium,
                        ),
                        bulletSize: 18.0,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                  Column(
                    children: [
                      CustomElevatedButton.blueFullWidth(
                        onPressed: () => _onStartPressed(context),
                        label: LocalizedTexts.start.tr(),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onStartPressed(BuildContext context) {
    context.router.push(
      EditFoodPreferencesRoute(
        mode: const EditFoodPreferencesPageMode.allergies(),
        fromLessonComplete: true,
        streamType: widget.streamType,
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) {
    return Future.value(true);
  }
}
