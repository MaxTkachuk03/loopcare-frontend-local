import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/unlock_config/feature/feature.dart';
import 'package:loopcare_frontend/core/domain/unlock_config/unlock_lock_feature/set_feature.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
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
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/category_label.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson_complete_page/widgets/unlock_physical_activities_feature.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_education/dashboard_education_bloc.dart';
import 'package:loopcare_frontend/injection.dart';

class PhysicalActivitiesCompletePage extends StatefulWidget {
  const PhysicalActivitiesCompletePage({super.key});

  @override
  State<PhysicalActivitiesCompletePage> createState() => _PhysicalActivitiesCompletePageState();
}

class _PhysicalActivitiesCompletePageState extends State<PhysicalActivitiesCompletePage> {
  @override
  void initState() {
    super.initState();
    final accountId = getIt<SharedStorageService>().account?.id;
    if (accountId == null) {
      return;
    }
    context.read<AuthenticationBloc>().add(
          AuthenticationEvent.unlockFeature(
            SetFeature(
              accountId: accountId,
              feature: const Feature(
                feature: UnlockedFeatureType.physicalActivities,
                unlocked: true,
                subFeatures: null,
              ),
            ),
          ),
        );
  }

  _onPressHandler(BuildContext context) {
    context.read<DashboardEducationBloc>().add(const DashboardEducationEvent.getDashboardLessons());
    context.router.popUntilRouteWithName(HomeRoute.name);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.petrol(
      appBar: CustomAppBar.petrol(
        title: LocalizedTexts.lesson.tr(),
        leading: CustomFilledIconButton.leadingPetrolLighter(),
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  UnderAppbar.petrol(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 22.0,
                              backgroundColor: AppColors.greenRegular,
                              child: Icon(Icons.check, size: 24, color: AppColors.white),
                            ),
                            const SizedBox(height: 22.0),
                            CustomText.bitter600(
                              '${LocalizedTexts.lessonCompleted.tr()}!',
                              style: context.textTheme.displayMedium?.copyWith(color: AppColors.white),
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
                            LocalizedTexts.physicalActivitiesCompletedDesc,
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
                      label: LocalizedTexts.backToToday,
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
