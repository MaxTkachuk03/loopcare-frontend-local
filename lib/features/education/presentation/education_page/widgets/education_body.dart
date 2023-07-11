import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_category.dart';
import 'package:loopcare_frontend/features/education/application/education_program/education_program_bloc.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_category_list.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_full_list.dart';

class EducationBody extends StatefulWidget {
  const EducationBody({Key? key}) : super(key: key);

  @override
  State<EducationBody> createState() => _EducationBodyState();
}

class _EducationBodyState extends State<EducationBody> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationProgramBloc, EducationProgramState>(
      builder: (BuildContext context, state) {

        if (state.data.isLoading) return const Loader();

        final lessons = state.data.lessons;

        if (state.data.currentCategory == LessonCategory.all) {
          return Stack(
            children: [
              Container(
                color: AppColors.orange,
                height: 40,
              ),
              Positioned.fill(
                child: MainContainer(
                  child: EducationFullList(
                    lessons: lessons,
                  ),
                ),
              )
            ],
          );
        }

        return MainContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 34.0,
              ),
              Text(
                state.data.currentCategory.label,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontFamily: ThemeConstants.bitterFontFamily,
                    ),
              ),
              const SizedBox(
                height: 14.0,
              ),
              Expanded(
                child: EducationCategoryList(
                  lessons: lessons,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
