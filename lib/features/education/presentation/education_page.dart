import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/education/application/education_program_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/lesson_category.dart';
import 'package:loopcare_frontend/features/education/presentation/widgets/education_app_bar.dart';
import 'package:loopcare_frontend/features/education/presentation/widgets/education_body.dart';
import 'package:loopcare_frontend/features/education/presentation/widgets/education_tab_bar.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({Key? key}) : super(key: key);

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  @override
  void initState() {
    context.read<EducationProgramBloc>().add(
          const EducationProgramEvent.getLessons(LessonCategory.all),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return const <Widget>[
              EducationTabBar(),
              EducationAppBar(),
            ];
          },
          body: const EducationBody(),
        ),
      ),
    );
  }
}
