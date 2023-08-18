import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_program/education_program_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_category.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_app_bar.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_body.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_tab_bar.dart';
import 'package:loopcare_frontend/features/home/application/home_bottom_navigation_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_education/dashboard_education_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dashboard/dashboard_navbar_items.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({Key? key}) : super(key: key);

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _introContainerKey = GlobalKey();

  List<Widget> categories = LessonCategory.values.map((v) => Tab(text: v.label)).toList();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      vsync: this,
      length: categories.length,
      animationDuration: Duration.zero,
      initialIndex: 0,
    );

    _tabController.addListener(_onTabsChanged);

    context.read<EducationProgramBloc>().add(const EducationProgramEvent.getLessons(LessonCategory.all));

    context.read<EducationLessonBloc>().add(const EducationLessonEvent.init());
  }

  void _jumpToLessonsList() {
    final dataState = context.read<EducationProgramBloc>().state.data;
    final activeLessonIndex = dataState.activeLessonIndex;
    final lessonWithCountdown = dataState.lessonWithCountdown;

    if (lessonWithCountdown == null && activeLessonIndex > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final size = _introContainerKey.currentContext?.size;
        _scrollController.jumpTo(size?.height ?? 0);
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabsChanged);
    _tabController.dispose();

    super.dispose();
  }

  _lessonCompleteListener(BuildContext context, EducationLessonState state) {
    final currentDate = context.read<MealsBloc>().state.getCurrentDate;

    context
      ..read<EducationProgramBloc>().add(
        EducationProgramEvent.getLessons(
          LessonCategory.values[_tabController.index],
        ),
      )
      ..read<DashboardEducationBloc>().add(
        DashboardEducationEvent.getDashboardLessons(
          currentDate: currentDate,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<EducationLessonBloc, EducationLessonState>(
          listenWhen: (prev, cur) => cur is LessonCompleted,
          listener: _lessonCompleteListener,
        ),
        BlocListener<HomeBottomNavigationBloc, HomeBottomNavigationState>(
          listenWhen: (prev, cur) => cur.activeTab == DashboardNavbarItems.education,
          listener: _tabsListener,
        ),
      ],
      child: SafeArea(
        child: BlocBuilder<EducationProgramBloc, EducationProgramState>(
          builder: (BuildContext context, state) {
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                EducationTabBar(
                  controller: _tabController,
                  tabs: categories,
                ),
                if (state.data.currentCategory == LessonCategory.all)
                  EducationAppBar(
                    containerKey: _introContainerKey,
                  ),
                SliverFillRemaining(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      EducationBody(),
                      EducationBody(),
                      EducationBody(),
                      EducationBody(),
                      EducationBody(),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void _onTabsChanged() {
    final currentTab = LessonCategory.values[_tabController.index];

    if (currentTab == LessonCategory.all) {
      _jumpToLessonsList();
    } else {
      _scrollController.jumpTo(0);
    }

    context.read<EducationProgramBloc>().add(EducationProgramEvent.getLessons(currentTab));
  }

  void _tabsListener(BuildContext context, HomeBottomNavigationState state) {
    _jumpToLessonsList();
  }
}
