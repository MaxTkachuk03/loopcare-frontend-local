import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/firebase_event_service.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/utils/scroll_controller_extensions.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_program/education_program_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_category.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_app_bar.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_card.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/education_tab_bar.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/progress_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_education/dashboard_education_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';

const double _lessonCardHeight = 175;

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _introContainerKey = GlobalKey();
  final PageStorageKey _listKey = const PageStorageKey('educationLessonPage');

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

    if (activeLessonIndex > 0) {
      final size = _introContainerKey.currentContext?.size;
      final offset = (size?.height ?? 0) + activeLessonIndex * _lessonCardHeight;

      _scrollController.scrollWithEase600(offset);
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

  _lessonsListener(BuildContext context, EducationProgramState state) {
    final currentTab = LessonCategory.values[_tabController.index];

    if (currentTab == LessonCategory.all) {
      _jumpToLessonsList();
    } else {
      _scrollController.scrollWithEase600(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<EducationLessonBloc, EducationLessonState>(
          listenWhen: (prev, cur) => cur is LessonCompleted, //TODO: Probably incorrect
          listener: _lessonCompleteListener,
        ),
        BlocListener<EducationProgramBloc, EducationProgramState>(
          listenWhen: (prev, cur) => cur is EducationProgramStateLoaded,
          listener: _lessonsListener,
        ),
      ],
      child: SafeArea(
        child: BlocBuilder<EducationProgramBloc, EducationProgramState>(
          builder: (BuildContext context, state) {
            final lessons = state.data.lessons;
            return CustomScrollView(
              key: _listKey,
              controller: _scrollController,
              slivers: [
                EducationTabBar(
                  controller: _tabController,
                  tabs: categories,
                ),
                if (state.data.currentCategory == LessonCategory.all) EducationAppBar(containerKey: _introContainerKey),
                state.maybeMap(
                    loading: (_) =>
                        const SliverToBoxAdapter(child: SizedBox(height: 500, child: Center(child: Loader()))),
                    orElse: () {
                      return SliverList(
                          delegate: SliverChildBuilderDelegate(childCount: lessons.length, (
                        BuildContext context,
                        int i,
                      ) {
                        final isLastElement = i + 1 == lessons.length;
                        final isFirstElement = i == 0;
                        final nextIsLocked = isLastElement ? true : lessons[i + 1].isLocked;

                        return Container(
                          key: PageStorageKey(lessons[i].id),
                          padding: const EdgeInsets.only(right: 22.0, left: 22.0),
                          height: _lessonCardHeight,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ProgressItem(
                                isFirst: isFirstElement,
                                isLast: isLastElement,
                                lesson: lessons[i],
                                nextIsLocked: nextIsLocked,
                              ),
                              const SizedBox(width: 4.0),
                              Expanded(
                                child: EducationCard(lesson: lessons[i]),
                              ),
                            ],
                          ),
                        );
                      }));
                    }),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onTabsChanged() {
    final currentTab = LessonCategory.values[_tabController.index];
    context.read<EducationProgramBloc>().add(EducationProgramEvent.getLessons(currentTab));

    AnalyticsEventService.instance.logEvent('education_screen_${currentTab.label.toLowerCase()}');
  }
}
