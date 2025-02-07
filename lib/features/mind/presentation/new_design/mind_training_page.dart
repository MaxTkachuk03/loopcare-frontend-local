import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/features/mind/domain/mind_analytics_mixin/mind_analytics_mixin.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';

import '../../../../core/presentation/app_bar/custom_app_bar.dart';
import '../../../../core/presentation/buttons/custom_elevated_button.dart';
import '../../../../core/presentation/buttons/custom_filled_icon_button.dart';
import '../../../../core/presentation/custom_safe_area.dart';
import '../../../../core/presentation/loader/loader.dart';
import '../../../../core/presentation/practice_lesson_list/practice_lesson_card.dart';
import '../../../../core/presentation/practice_lesson_list/practice_lesson_card_status_types.dart';
import '../../../../core/presentation/routes/app_router.dart';
import '../../../../core/presentation/themes/themes.dart';
import '../../../../core/presentation/widgets/main_container.dart';
import '../../../../localization/service/Localized_texts.dart';

@RoutePage()
class MindTrainingPage extends StatefulWidget {
  const MindTrainingPage({super.key});

  @override
  State<MindTrainingPage> createState() => _MindTrainingPageState();
}

class _MindTrainingPageState extends State<MindTrainingPage> with MindAnalyticsMixin {
  static const textColor = AppColors.blueDarker;

  void onTechniqueSelect(technique) => context
    ..read<MindBloc>().add(MindEvent.getExercises(techniqueId: technique.id))
    ..router.pushNamed(AppRoutes.techniqueExercises);

  void listener(BuildContext context, MindState state) {
    state.mapOrNull(
      error: errorHandler,
    );
  }

  void errorHandler(MindState state) =>
      context.showError(content: CustomText(state.data.errorKey.tr()));

  Future<void> getTechniques() async =>
      context.read<MindBloc>().add(const MindEvent.getTechniques());

  @override
  void initState() {
    super.initState();
    getTechniques();
    track(AnalyticsEvents.mindOpen);
  }

  @override
  void dispose() {
    track(AnalyticsEvents.mindClose);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      color: AppColors.white,
      appBar: CustomAppBar.petrol(
        title: LocalizedTexts.mindDashboardTitle.tr(),
        leading: CustomFilledIconButton.leadingPetrolLighter(),
      ),
      body: CustomSafeArea(child: BlocBuilder<MindBloc, MindState>(
        builder: (context, state) {
          final title = state.data.mindInfo?.title ?? '';
          final subtitle = state.data.mindInfo?.subtitle ?? '';
          final description = state.data.mindInfo?.shortIntroduction ?? '';

          return state.maybeWhen(
              loading: (_) => const Loader(),
              orElse: () {
                return MainContainer(
                  child: CustomScrollView(slivers: [
                    // Title -->
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 28),
                      sliver: SliverToBoxAdapter(
                        child: CustomText.bitter600(
                          title,
                          style: context.textTheme.displayLarge?.copyWith(color: textColor),
                        ),
                      ),
                    ),
                    // Subtitle -->
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 20),
                      sliver: SliverToBoxAdapter(
                        child: CustomText.bitter600(
                          subtitle,
                          style: context.textTheme.bodyLarge?.copyWith(color: textColor),
                        ),
                      ),
                    ),
                    // Short Description -->
                    if (description.isNotEmpty)
                      SliverPadding(
                        padding: const EdgeInsets.only(top: 20),
                        sliver: SliverToBoxAdapter(
                          child: CustomText.w400(
                            description,
                            style: context.textTheme.bodyMedium?.copyWith(color: textColor),
                          ),
                        ),
                      ),
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 20),
                      sliver: SliverToBoxAdapter(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomElevatedButton.transparentSmall(
                            streamColor: AppColors.petrolRegular,
                            label: LocalizedTexts.learnMoreButton.tr(),
                            onPressed: () => context.router.pushNamed(AppRoutes.mindExplanation),
                          ),
                        ),
                      ),
                    ),
                    const SliverPadding(
                      padding: EdgeInsets.only(top: 28),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final technique = state.data.sortedTechniques[index];
                          final cardStatus = technique.isLocked
                              ? PracticeLessonCardStatusTypes.locked
                              : PracticeLessonCardStatusTypes.unlocked;

                          return PracticeLessonCard(
                            key: ValueKey(technique.id),
                            url: technique.image,
                            text: technique.title,
                            buttonText: LocalizedTexts.exercise.tr(),
                            status: cardStatus.name,
                            onPressed: cardStatus == PracticeLessonCardStatusTypes.locked
                                ? null
                                : () {
                                    onTechniqueSelect(technique);
                                  },
                          );
                        },
                        childCount: state.data.sortedTechniques.length,
                      ),
                    ),
                  ]),
                );
              });
        },
      )),
    );
  }
}
