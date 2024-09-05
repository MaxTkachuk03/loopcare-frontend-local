import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/html_renderer/html_linc_content_render.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/presentation/widgets/get_label_by_stream_type.dart';
import 'package:loopcare_frontend/features/education/presentation/widgets/lesson_image_header.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';

class LessonTextBody extends StatelessWidget {
  final RiverModuleStreamType streamType;
  final void Function() onNextPressed;

  const LessonTextBody({super.key, required this.onNextPressed, required this.streamType});

  @override
  Widget build(BuildContext context) {
    return ScrollableContainer(
      child: Column(
        children: [
          const SizedBox(height: 32.0),
          const LessonImageHeader(),
          const SizedBox(height: 28.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: getLabelByStreamType(streamType),
              ),
              const SizedBox(height: 18.0),
              BlocBuilder<EducationLessonBloc, EducationLessonState>(
                builder: (context, state) => HtmlLaunchContentRender(url: state.data.htmlUrl),
              ),
              const SizedBox(height: 64.0),
              MainContainer(
                child: CustomElevatedButton.blueFullWidth(
                  onPressed: onNextPressed,
                  label: LocalizedTexts.next.tr(),
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ],
      ),
    );
  }
}
