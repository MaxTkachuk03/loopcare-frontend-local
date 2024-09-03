import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/simple_progress_bar.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';

@RoutePage()
class QuizIntroPage extends StatelessWidget {
  final int lessonId;
  final RiverModuleStreamType streamType;

  const QuizIntroPage({super.key, required this.lessonId, required this.streamType});

  void _onStart(BuildContext context) {
    context.router.push(QuizQuestionRoute(step: 0, streamType: streamType));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      color: streamType.lightestColor,
      appBar: CustomAppBar(
        backgroundColor: streamType.regularColor,
        textTheme: streamType.appBarTextTheme,
        title: LocalizedTexts.quiz.tr(),
        subtitle: LocalizedTexts.introduction.tr(),
        leading: CustomFilledIconButton.fromColor(color: streamType.lighterColor),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(72),
          child: SimpleProgressBar(
            backgroundColor: streamType.regularColor,
            progressFillColor: streamType.lightestColor,
            progressEmptyColor: AppColors.white.withOpacity(0.45),
            progress: 33,
          ),
        ),
      ),
      body: CustomSafeArea(
        child: ScrollableContainer(
          child: BlocBuilder<EducationLessonBloc, EducationLessonState>(
            builder: (context, state) {
              return MainContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 30.0),
                        SizedBox(
                          height: 365,
                          child: NetworkImageWithCache(url: state.data.imageUrl),
                        ),
                        const SizedBox(height: 34.0),
                        CustomText.bitter600(
                          LocalizedTexts.quiz.tr().toUpperCase(),
                          style: context.textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 20.0),
                        CustomText.w400(
                          state.data.quizInstruction,
                          style: context.textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0, top: 16.0),
                      child: CustomElevatedButton.blueFullWidth(
                        onPressed: () => _onStart(context),
                        label: LocalizedTexts.letsGo.tr(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
