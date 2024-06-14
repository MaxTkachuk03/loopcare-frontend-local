import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';

import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

// TODO remove
class ThemeComponentsPage extends StatefulWidget {
  const ThemeComponentsPage({super.key});

  @override
  State<ThemeComponentsPage> createState() => _ThemeComponentsPageState();
}

class _ThemeComponentsPageState extends State<ThemeComponentsPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold.coralLightest(
      appBar: CustomAppBar.blue(
        title: 'Title',
        subtitle: 'Step 1 of 2',
        leading: CustomFilledIconButton.leadingBlueLighter(onPressed: () {}),
      ),
      body: const ScrollableContainer(
        child: MainContainer(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
