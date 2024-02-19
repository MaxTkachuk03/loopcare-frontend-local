import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_custom_definitions.dart';
import 'package:loopcare_frontend/core/domain/analytics/firebase_event_list.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/dashboard/application/programs_in_progress_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/physical_programs/widgets/program_card.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_assesment/widgets/assesment_block.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_assesment/widgets/like_unlike_block.dart';

const physicalProgramAlreadyLogged = 'physical_program_already_logged';

class ProgramAssessmentPage extends StatefulWidget {
  final VoidCallback onDisposeCb;

  const ProgramAssessmentPage({super.key, required this.onDisposeCb});

  @override
  State<ProgramAssessmentPage> createState() => _ProgramAssessmentPageState();
}

class _ProgramAssessmentPageState extends State<ProgramAssessmentPage> {
  int? assessmentScore;
  bool? assessmentLike;
  bool _needToCallDisposeCb = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PhysicalProgramsBloc, PhysicalProgramsState>(
          listener: _physicalProgramErrorListener,
          listenWhen: (prev, cur) => prev is Loading && cur is Error,
        ),
        BlocListener<PhysicalProgramsBloc, PhysicalProgramsState>(
            listener: _physicalProgramLoggedListener,
            listenWhen: (prev, cur) => prev is Loading && cur is ProgramUpdated),
      ],
      child: BlocBuilder<PhysicalProgramsBloc, PhysicalProgramsState>(
        builder: (context, state) {
          if (state.data.isLoading) {
            return CustomScaffold.yellowLightest(
              appBar: CustomAppBar.yellow(
                title: '${LocalizedTexts.didItWorkOutForYou.tr()}?',
                leading: CustomFilledIconButton.leadingYellowLighter(),
              ),
              body: const SafeArea(
                child: Loader(),
              ),
            );
          }

          return CustomScaffold.yellowLightest(
            appBar: CustomAppBar.yellow(
              title: '${LocalizedTexts.didItWorkOutForYou.tr()}?',
              leading: CustomFilledIconButton.leadingYellowLighter(),
            ),
            body: ScrollableContainer(
              child: MainContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20.0),
                        if (state.data.currentProgram != null)
                          ProgramCard.onlyView(
                            program: state.data.currentProgram!,
                            bgColor: AppColors.white,
                            borderColor: AppColors.yellowRegular,
                            size: const ProgramCardSize.small(),
                          ),
                        const SizedBox(height: 20.0),
                        AssesmentBlock(
                          onScoreChange: onScoreChange,
                        ),
                        const SizedBox(height: 25),
                        Center(
                          child: CustomText.bitter600(
                            '${LocalizedTexts.didYouLikeThisProgram.tr()}?',
                            style: context.textTheme.bodyLarge,
                          ),
                        ),
                        const SizedBox(height: 25),
                        LikeUnlikeBlock(
                          onLikeChange: (bool like) {
                            onLikeChange(like);
                          },
                        ),
                        const SizedBox(height: 45),
                      ],
                    ),
                    Column(
                      children: [
                        CustomOutlinedButton.blueFullWidth(
                          onPressed: () {
                            final programId = state.data.currentProgram?.id ?? -1;
                            AnalyticsEventService.instance.logEvent(
                              FirebaseEvents.programCompletedWithoutLogging,
                              parameters: {
                                CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
                                CustomDefinitions.programId: programId.toString(),
                              },
                            );
                            context.router.popUntilRouteWithName(HomeRoute.name);
                          },
                          label: LocalizedTexts.backToTodayNotLogged.tr(),
                        ),
                        const SizedBox(height: 12),
                        CustomElevatedButton.blueFullWidth(
                          onPressed: assessmentLike != null && assessmentScore != null
                              ? () => logAssessment(state.data.currentProgram?.id ?? -1)
                              : null,
                          label: LocalizedTexts.logActivity.tr(),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    if (_needToCallDisposeCb) {
      widget.onDisposeCb();
    }

    super.dispose();
  }

  void logAssessment(int programId) {
    final assessmentScoreValue = assessmentScore;
    final assessmentLikeValue = assessmentLike;
    if (assessmentScoreValue == null || assessmentLikeValue == null) return;

    AnalyticsEventService.instance.logProgramAssessmentEvent(
      FirebaseEvents.programAssessmentScreen,
      assessmentScore!,
      '${assessmentLike!}',
      programId,
    );

    AnalyticsEventService.instance.logEvent(
      FirebaseEvents.programCompletedWithLogging,
      parameters: {
        CustomDefinitions.timestamp: DateTime.now().toIso8601String(),
        CustomDefinitions.programId: programId.toString(),
      },
    );

    context.read<PhysicalProgramsBloc>().add(
          PhysicalProgramsEvent.logAssessment(
            assessmentScoreValue,
            assessmentLikeValue,
          ),
        );
  }

  void onScoreChange(int score) {
    setState(() {
      assessmentScore = score;
    });
  }

  void onLikeChange(bool like) {
    setState(() {
      assessmentLike = like;
    });
  }

  void _physicalProgramErrorListener(BuildContext context, PhysicalProgramsState state) {
    final error = state.data.error;

    if (error != null) {
      final errorMessage = error.maybeMap(
        conflict: (error) {
          return error.error.message == physicalProgramAlreadyLogged
              ? LocalizedTexts.physicalProgramAlreadyLogged.tr()
              : LocalizedTexts.somethingIsIncorrect.tr();
        },
        orElse: () => LocalizedTexts.somethingIsIncorrect.tr(),
      );
      context.showError(content: Text(errorMessage));
    }
  }

  void _physicalProgramLoggedListener(BuildContext context, PhysicalProgramsState state) {
    setState(() {
      _needToCallDisposeCb = false;
    });

    final program = state.data.currentProgram;

    if (program != null) {
      context.read<ProgramsInProgressBloc>().add(ProgramsInProgressEvent.removeProgram(program.id));
    }

    context.router.popUntilRouteWithName(HomeRoute.name);
  }
}
