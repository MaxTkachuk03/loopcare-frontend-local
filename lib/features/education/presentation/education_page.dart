import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/education/presentation/widgets/education_app_bar.dart';
import 'package:loopcare_frontend/features/education/presentation/widgets/education_body.dart';
import 'package:loopcare_frontend/features/education/presentation/widgets/education_tab_bar.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({Key? key}) : super(key: key);

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
