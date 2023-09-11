import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/unlocked_feature_type.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/progress_bar.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/physical_activities_preferences_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/preferences/widgets/activity_type_chips.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/preferences/widgets/flexibility_chips.dart';

class PhysicalActivitiesActivityTypePage extends StatefulWidget {
  const PhysicalActivitiesActivityTypePage({Key? key}) : super(key: key);

  @override
  State<PhysicalActivitiesActivityTypePage> createState() => _PhysicalActivitiesActivityTypePageState();
}

class _PhysicalActivitiesActivityTypePageState extends State<PhysicalActivitiesActivityTypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              LocalizedTexts.physicalActivitiesPreferences.tr(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              LocalizedTexts.currentStep.translateWithNamedArgs({
                'currentStep': '2',
                'totalSteps': '2',
              }),
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
                    progress: 90,
                  ),
                  const SizedBox(height: 30.0),
                  MainContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocalizedTexts.whatWouldYouLikeToStartWorkingOn.translation,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16.0),
                        const ActivityTypeChips(),
                        const SizedBox(height: 16.0),
                        Text(
                          LocalizedTexts.youCanAlsoOptionally.translation,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16.0),
                        const FlexibilityChips(),
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
                    child: BlocBuilder<PhysicalActivitiesPreferencesBloc, PhysicalActivitiesPreferencesState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () => state.data.isTargetsSet ? _onNext(context) : null,
                          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                                backgroundColor: MaterialStateProperty.all(AppColors.orangeDark),
                              ),
                          child: Text(LocalizedTexts.next.tr()),
                        );
                      },
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

  void _onNext(BuildContext context) {
    context
        .read<PhysicalActivitiesPreferencesBloc>()
        .add(const PhysicalActivitiesPreferencesEvent.savePreferences());

    final bloc = context.read<AuthenticationCubit>();

    if (!bloc.state.unlockedFeatures.contains(UnlockedFeatureType.physicalActivities)) {
      context.router.pushNamed(AppRoutes.physicalActivitiesComplete);
    } else {
      context.router.popUntilRoot();
    }
  }
}
