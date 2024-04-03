import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/simple_progress_bar.dart';
import 'package:loopcare_frontend/features/quizzes/application/quizzes_bloc.dart';

class QuizzesIntroPage extends StatefulWidget {
  final int lessonId;

  const QuizzesIntroPage({super.key, required this.lessonId});

  @override
  State<QuizzesIntroPage> createState() => _QuizzesIntroPageState();
}

class _QuizzesIntroPageState extends State<QuizzesIntroPage> {
  @override
  void initState() {
    super.initState();

    context.read<QuizzesBloc>().add(QuizzesEvent.getLessonQuizzes(widget.lessonId));
  }

  void _onStart() {
    context.router.push(QuizzesQuestionsRoute(step: 0));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.petrolLightest(
      appBar: CustomAppBar.petrol(
        title: LocalizedTexts.quiz.tr(),
        subtitle: LocalizedTexts.introduction.tr(),
        leading: CustomFilledIconButton.leadingPetrolLighter(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(72),
          child: SimpleProgressBar.petrol(progress: 33),
        ),
      ),
      body: CustomSafeArea(
        child: ScrollableContainer(
          child: BlocBuilder<QuizzesBloc, QuizzesState>(
            builder: (context, state) {
              return state.maybeMap(
                loading: (_) => const Loader(),
                orElse: () => const SizedBox.shrink(),
                updated: (s) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainContainer(
                        child: Column(
                          children: [
                            const SizedBox(height: 30.0),
                            SizedBox(
                              height: 365,
                              child: NetworkImageWithCache(url: s.data.quizzes.first.visual ?? ''),
                            ),
                            const SizedBox(height: 34.0),
                            CustomText.bitter600(
                              LocalizedTexts.quiz.tr().toUpperCase(),
                              style: context.textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 20.0),
                            BlocBuilder<QuizzesBloc, QuizzesState>(
                              builder: (context, state) {
                                var quizzes = state.data.quizzes;
                                return CustomText.w400(
                                  quizzes.isNotEmpty ? quizzes.first.instruction : '',
                                  style: context.textTheme.bodyMedium,
                                  textAlign: TextAlign.center,
                                );
                              },
                            ),
                            const SizedBox(height: 16.0),
                          ],
                        ),
                      ),
                      MainContainer(
                        child: Column(
                          children: [
                            CustomElevatedButton.blueFullWidth(
                              onPressed: _onStart,
                              label: LocalizedTexts.letsGo.tr(),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
