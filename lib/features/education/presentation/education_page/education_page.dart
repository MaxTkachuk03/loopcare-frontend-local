import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_program/education_program_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_category.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_app_bar.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_body.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_tab_bar.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({Key? key}) : super(key: key);

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Widget> categories =
      LessonCategory.values.map((v) => Tab(text: v.label)).toList();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
        vsync: this,
        length: categories.length,
        animationDuration: Duration.zero,
        initialIndex: 0);

    _tabController.addListener(_onTabsChanged);

    context.read<EducationProgramBloc>().add(
          const EducationProgramEvent.getLessons(LessonCategory.all),
        );

    context.read<EducationLessonBloc>().add(const EducationLessonEvent.init());
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabsChanged);

    super.dispose();
  }

  _lessonCompleteListener(BuildContext context, EducationLessonState state) {
    context.read<EducationProgramBloc>().add(
          EducationProgramEvent.getLessons(
            LessonCategory.values[_tabController.index],
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EducationLessonBloc, EducationLessonState>(
      listenWhen: (prev, cur) => cur is LessonCompleted,
      listener: _lessonCompleteListener,
      child: SafeArea(
        child: BlocBuilder<EducationProgramBloc, EducationProgramState>(
          builder: (BuildContext context, state) {
            return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  EducationTabBar(
                    controller: _tabController,
                    tabs: categories,
                  ),
                  if (state.data.currentCategory == LessonCategory.all)
                    const EducationAppBar(),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: const [
                  EducationBody(),
                  EducationBody(),
                  EducationBody(),
                  EducationBody(),
                  EducationBody(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _onTabsChanged() {
    context.read<EducationProgramBloc>().add(
          EducationProgramEvent.getLessons(
            LessonCategory.values[_tabController.index],
          ),
        );
  }
}
