import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/orange_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_assesment/widgets/assesment_block.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_assesment/widgets/like_unlike_block.dart';
import 'package:loopcare_frontend/injection.dart';

AppConfig appConfig = getIt<AppConfig>();

class ProgramAssesmentPage extends StatefulWidget {
  const ProgramAssesmentPage({Key? key}) : super(key: key);

  @override
  State<ProgramAssesmentPage> createState() => _ProgramAssesmentPageState();
}

class _ProgramAssesmentPageState extends State<ProgramAssesmentPage> {
  int assesmentScore = 0;
  bool assesmentLike = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhysicalProgramsBloc, PhysicalProgramsState>(
      builder: (context, state) {
        if (state.data.isLoading) {
          return Scaffold(
            appBar: OrangeAppBar(title: state.data.programType.name),
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
                  score: state.data.currentProgram?.assessment?.score,
                  onScoreChange: (int score) {
                    onScoreChange(score);
                  },
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
                  like: state.data.currentProgram?.assessment?.like,
                  onLikeChange: (bool like) {
                    onLikeChange(like);
                  },
                ),
                const SizedBox(height: 45),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: OutlinedButton(
                    style:
                        Theme.of(context).outlinedButtonTheme.style?.copyWith(
                              side: MaterialStateProperty.all(
                                const BorderSide(
                                  width: 1.0,
                                  color: AppColors.blueDark,
                                ),
                              ),
                            ),
                    onPressed: () => context.router.pop(),
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
                    onPressed: () => logAssesment(),
                    style: Theme.of(context)
                        .elevatedButtonTheme
                        .style
                        ?.copyWith(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.orangeDark),
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
    );
  }

  void logAssesment() {
    context.read<PhysicalProgramsBloc>().add(
          PhysicalProgramsEvent.logAssesment(
            assesmentScore,
            assesmentLike,
          ),
        );
    context.router.pop();
  }

  void onScoreChange(int score) {
    setState(() {
      assesmentScore = score;
    });
  }

  void onLikeChange(bool like) {
    setState(() {
      assesmentLike = like;
    });
  }
}
