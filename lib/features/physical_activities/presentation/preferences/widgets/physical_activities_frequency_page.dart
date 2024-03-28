import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/physical_activities_preferences_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/preferences/widgets/frequency_chips.dart';
import 'package:loopcare_frontend/injection.dart';

class PhysicalActivitiesFrequencyPage extends StatefulWidget {
  final bool profileInvoke;

  const PhysicalActivitiesFrequencyPage({super.key, this.profileInvoke = false});

  @override
  State<PhysicalActivitiesFrequencyPage> createState() => _PhysicalActivitiesFrequencyPageState();
}

class _PhysicalActivitiesFrequencyPageState extends State<PhysicalActivitiesFrequencyPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<PhysicalActivitiesPreferencesBloc>()
        .add(const PhysicalActivitiesPreferencesEvent.getPreferences());
  }

  void _onErrorHandler(PhysicalActivitiesPreferencesState state) =>
      context.showError(content: Text(state.data.error?.error.toString() ?? ''));

  void _onChangeListener(BuildContext context, PhysicalActivitiesPreferencesState state) {
    state.maybeMap(
      orElse: () => {},
      error: _onErrorHandler,
      preferencesLoaded: _onUpdateHandler,
    );
  }

  void _onUpdateHandler(PhysicalActivitiesPreferencesState state) {
    if (widget.profileInvoke) {
      context.router.pop();
      return;
    }

    if (state.data.needActivitiesType) {
      context.router.pushNamed(AppRoutes.physicalActivitiesActivityType);
      return;
    }

    final lessonBloc = context.read<EducationLessonBloc>();

    if (lessonBloc.state.data.hasQuiz) {
      context.router.push(QuizzesIntroRoute(lessonId: lessonBloc.state.data.lessonId));
      return;
    }

    final isPhysicalActivitiesUnlocked =
        getIt<SharedStorageService>().account?.isPhysicalActivitiesUnlocked ?? false;

    if (lessonBloc.state.data.questions.isEmpty && !isPhysicalActivitiesUnlocked) {
      context.router.pushNamed(AppRoutes.physicalActivitiesComplete);
    }
  }

  void _onNext() {
    context
        .read<PhysicalActivitiesPreferencesBloc>()
        .add(const PhysicalActivitiesPreferencesEvent.savePreferences());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhysicalActivitiesPreferencesBloc, PhysicalActivitiesPreferencesState>(
      listenWhen: (prev, cur) =>
          prev is Saving && context.router.current.name == PhysicalActivitiesFrequencyRoute.name,
      listener: _onChangeListener,
      child: CustomScaffold(
        withBg: false,
        color: widget.profileInvoke ? AppColors.blueLightest : AppColors.petrolLightest,
        appBar: CustomAppBar(
          title: LocalizedTexts.trainingFrequency.tr(),
          textTheme: CustomAppBarTextTheme.light,
          backgroundColor: widget.profileInvoke ? AppColors.blueRegular : AppColors.petrolRegular,
          leading: widget.profileInvoke
              ? CustomFilledIconButton.leadingBlueLighter()
              : CustomFilledIconButton.leadingPetrolLighter(),
        ),
        body: CustomSafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 30.0),
                      CustomText.bitter500(
                        LocalizedTexts.physicalActivitiesFrequencyTitle.translation,
                        style: context.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 28.0),
                      widget.profileInvoke ? const FrequencyChips.coral() : const FrequencyChips.green(),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                  Column(
                    children: [
                      BlocBuilder<PhysicalActivitiesPreferencesBloc, PhysicalActivitiesPreferencesState>(
                        builder: (context, state) {
                          return CustomElevatedButton.blueFullWidth(
                            onPressed: state.data.isFrequencySet ? _onNext : null,
                            label: LocalizedTexts.confirm.tr(),
                          );
                        },
                      ),
                      const SizedBox(height: 8.0),
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
}
