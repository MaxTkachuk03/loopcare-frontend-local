import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/river_module_view.dart';

@RoutePage()
class RiverPage extends StatefulWidget {
  const RiverPage({super.key});

  @override
  State<RiverPage> createState() => _RiverPageState();
}

class _RiverPageState extends State<RiverPage> {

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blueLightest(
      body: CustomSafeArea(
        child: PageView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return RiverScreen(
              completedDate: null,
              isCompleted: false,
              totalDays: 7,
              title: 'Title',
              page: index + 1,
            );
          },
        ),
      ),
    );
  }
}
