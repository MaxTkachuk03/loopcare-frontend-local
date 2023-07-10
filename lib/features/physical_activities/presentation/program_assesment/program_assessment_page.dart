import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/dto/error_response.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/dashboard/application/programs_in_progress_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_assesment/widgets/assesment_block.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_assesment/widgets/like_unlike_block.dart';

const physicalProgramAlreadyLogged = 'physical_program_already_logged';

class ProgramAssessmentPage extends StatefulWidget {
  final VoidCallback onDisposeCb;

  const ProgramAssessmentPage({Key? key, required this.onDisposeCb}) : super(key: key);

  @override
  State<ProgramAssessmentPage> createState() => _ProgramAssessmentPageState();
}

class _ProgramAssessmentPageState extends State<ProgramAssessmentPage> {
  int? assessmentScore;
  bool? assessmentLike;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PhysicalProgramsBloc, PhysicalProgramsState>(
          listener: _physicalProgramErrorListener,
          listenWhen: (prev, cur) => prev is Loading && cur is ErrorLoadingPrograms,
        ),
        BlocListener<PhysicalProgramsBloc, PhysicalProgramsState>(
            listener: _physicalProgramLoggedListener,
            listenWhen: (prev, cur) => prev is Loading && cur is ProgramUpdated),
      ],
      child: BlocBuilder<PhysicalProgramsBloc, PhysicalProgramsState>(
        builder: (context, state) {
          if (state.data.isLoading) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.router.pop(),
                ),
              ),
              body: const SafeArea(
                child: Loader(),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.router.pop(),
              ),
            ),
            body: ScrollableContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 32.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      LocalizedTexts.physicalActivity.translation.toUpperCase(),
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontSize: ThemeConstants.fontSize12,
                            color: AppColors.orangeDark,
                          ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: AutoSizeText(
                      state.data.currentProgram?.name ?? '',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontFamily: ThemeConstants.bitterFontFamily,
                          ),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      state.data.currentProgram?.programDescription ?? '',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.darkGreen,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                  const SizedBox(height: 7),
                  AssesmentBlock(
                    onScoreChange: onScoreChange,
                  ),
                  const SizedBox(height: 45),
                  Center(
                    child: Text(
                      LocalizedTexts.didYouLikeThisProgram.translation,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  LikeUnlikeBlock(
                    onLikeChange: (bool like) {
                      onLikeChange(like);
                    },
                  ),
                  const SizedBox(height: 45),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: OutlinedButton(
                      style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                            side: MaterialStateProperty.all(
                              const BorderSide(width: 1.0, color: AppColors.blueDark),
                            ),
                          ),
                      onPressed: () => context.router.popUntilRouteWithName(HomeRoute.name),
                      child: Text(
                        LocalizedTexts.backToTodayNotLogged.translation,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.blueDark,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: ElevatedButton(
                      onPressed:
                          assessmentLike != null && assessmentScore != null ? () => logAssessment() : null,
                      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return AppColors.greyMid;
                            }

                            return AppColors.orangeDark;
                          },
                        ),
                      ),
                      child: Text(
                        LocalizedTexts.logActivity.translation,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 54),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    widget.onDisposeCb();

    super.dispose();
  }

  void logAssessment() {
    final assessmentScoreValue = assessmentScore;
    final assessmentLikeValue = assessmentLike;
    if (assessmentScoreValue == null || assessmentLikeValue == null) return;

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
          final message = ErrorResponse.fromJson(
            error.error.response?.data ?? {},
          ).message;

          return message == physicalProgramAlreadyLogged
              ? LocalizedTexts.physicalProgramAlreadyLogged.translation
              : LocalizedTexts.somethingIsIncorrect.translation;
        },
        orElse: () => LocalizedTexts.somethingIsIncorrect.translation,
      );

      showAppSnackBar(
        context: context,
        text: errorMessage,
        background: AppColors.red,
        textColor: Colors.white,
      );
    }
  }

  void _physicalProgramLoggedListener(BuildContext context, PhysicalProgramsState state) {
    final program = state.data.currentProgram;

    if (program != null) {
      context.read<ProgramsInProgressBloc>().add(ProgramsInProgressEvent.removeProgram(program.id));
    }

    context.router.popUntilRouteWithName(HomeRoute.name);
  }
}
