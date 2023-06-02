import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    with TickerProviderStateMixin {
  late TabController _tabController;
  late int _selectedIndex;

  List<Widget> categories =
      LessonCategory.values.map((v) => Tab(text: v.label)).toList();

  @override
  void initState() {
    _tabController = TabController(
      vsync: this,
      length: categories.length,
    );

    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
    });

    context.read<EducationProgramBloc>().add(
          const EducationProgramEvent.getLessons(LessonCategory.all),
        );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: LessonCategory.values.length,
      child: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              EducationTabBar(
                controller: _tabController,
                tabs: categories,
              ),
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
        ),
      ),
    );
  }
}
