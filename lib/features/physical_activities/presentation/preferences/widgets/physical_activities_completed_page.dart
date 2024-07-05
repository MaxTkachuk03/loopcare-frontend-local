import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/shapes/under_appbar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/category_label.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/unlock_physical_activities_feature.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_stream_type.dart';

@RoutePage()
class PhysicalActivitiesCompletePage extends StatefulWidget {
  final RiverModuleStreamType streamType;

  const PhysicalActivitiesCompletePage({super.key, required this.streamType});

  @override
  State<PhysicalActivitiesCompletePage> createState() => _PhysicalActivitiesCompletePageState();
}

class _PhysicalActivitiesCompletePageState extends State<PhysicalActivitiesCompletePage> {
  @override
  void initState() {
    super.initState();
    if (!context.read<EducationLessonBloc>().state.data.isLessonCompleted) {
      // TODO check this flow and why we need to complete lesson here
      // context.read<EducationLessonBloc>().add(const EducationLessonEvent.completeLesson());
    }
  }

  _onPressHandler(BuildContext context) {
    context.read<AuthenticationBloc>().add(const AuthenticationEvent.getAccount());
    context.router.popUntilRouteWithName(HomeRoute.name);
  }

  CustomAppBarTextTheme get _theme => widget.streamType.appBarTextTheme;

  bool get _isLightTheme => _theme == CustomAppBarTextTheme.light;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      color: widget.streamType.offRegularColor,
      appBar: CustomAppBar(
        backgroundColor: widget.streamType.regularColor,
        textTheme: widget.streamType.appBarTextTheme,
        title: LocalizedTexts.lesson.tr(),
        leading: CustomFilledIconButton.fromColor(color: widget.streamType.lighterColor),
      ),
      body: CustomSafeArea(
        child: ScrollableContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  UnderAppbar(
                    fillColor: widget.streamType.regularColor,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 22.0,
                              backgroundColor:
                                  _isLightTheme ? AppColors.greenRegular : AppColors.blueRegular,
                              child: const Icon(Icons.check, size: 24, color: AppColors.white),
                            ),
                            const SizedBox(height: 22.0),
                            CustomText.bitter600(
                              '${LocalizedTexts.lessonCompleted.tr()}!',
                              style:
                                  context.textTheme.displayMedium?.copyWith(color: AppColors.white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  MainContainer(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      decoration: const BoxDecoration(
                        color: AppColors.petrolLightest,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CategoryLabel.physicalActivity(),
                          const SizedBox(height: 10),
                          CustomText.bitter600(
                            LocalizedTexts.physicalActivitiesCompletedTitle.tr(),
                            style: context.textTheme.displayLarge,
                          ),
                          const SizedBox(height: 10),
                          CustomText.w400(
                            LocalizedTexts.physicalActivitiesCompletedDesc.tr(),
                            style: context.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const MainContainer(child: UnlockPhysicalActivitiesFeature()),
                ],
              ),
              MainContainer(
                child: Column(
                  children: [
                    CustomElevatedButton.blueFullWidth(
                      onPressed: () => _onPressHandler(context),
                      label: LocalizedTexts.backToEducation.tr(),
                    ),
                    const SizedBox(height: 30.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
