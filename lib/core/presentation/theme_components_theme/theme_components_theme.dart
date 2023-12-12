import 'package:flutter/material.dart';

import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';

import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

class ThemeComponentsPage extends StatelessWidget {
  const ThemeComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blue(
      appBar: CustomAppBar.blue(
        title: 'Title',
        subtitle: 'Step 1 of 2',
        leading: CustomFilledIconButton.leadingBlueLighter(onPressed: () {}),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () {}),
        ],
      ),
      body: ScrollableContainer(
        child: MainContainer(
          child: CustomFilledIconButton.leadingBlueLighter(onPressed: () {}),
        ),
      ),
    );
  }
}
