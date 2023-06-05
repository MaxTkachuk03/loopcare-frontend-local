import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/education_lesson_page_type.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/lesson_audio_body.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/lesson_text_body.dart';

class LessonPage extends StatefulWidget {
  final int lessonId;
  final int pageIndex;

  const LessonPage({
    Key? key,
    @PathParam('lessonId') required this.lessonId,
    @PathParam('pageIndex') required this.pageIndex,
  }) : super(key: key);

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  _onNextPressed() {
    final lessonBloc = context.read<EducationLessonBloc>();

    lessonBloc.add(const EducationLessonEvent.nextPage());

    if (lessonBloc.state.data.isLastPage) {
      context.router.pushNamed(AppRoutes.lessonComplete);
      return;
    }

    int pageIndex = widget.pageIndex + 1;

    context.router.pushNamed('/lesson/${widget.lessonId}/page/$pageIndex');
  }

  _onPrevPressed() {
    context
        .read<EducationLessonBloc>()
        .add(const EducationLessonEvent.prevPage());

    context.router.pop();
  }

  Future<bool> _onWillPop() {
    return Future.value(true);
  }

  _errorListener(BuildContext context, EducationLessonState state) {
    showAppSnackBar(
      context: context,
      text: 'Something went wrong, try again',
      background: AppColors.red,
      textColor: Colors.white,
    );
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocConsumer<EducationLessonBloc, EducationLessonState>(
        listenWhen: (prev, cur) => cur is ErrorGettingLessons,
        listener: _errorListener,
        builder: (BuildContext context, state) {
          return state.maybeMap(
            loading: (_) => const Loader(),
            contentLoaded: (s) {
              final currentPage = s.data.currentPage;

              if (currentPage.type == EducationLessonPageType.text) {
                return LessonTextPage(
                  onNextPressed: _onNextPressed,
                  onPrevPressed: _onPrevPressed,
                  content: currentPage.content,
                );
              }
              if (currentPage.type == EducationLessonPageType.audio) {
                return LessonAudioPage(
                  onNextPressed: _onNextPressed,
                  onPrevPressed: _onPrevPressed,
                );
              }
              return const SizedBox.shrink();
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
