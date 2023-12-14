import 'package:flutter/material.dart';

import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';

import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';

import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

class ThemeComponentsPage extends StatelessWidget {
  const ThemeComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.coralLightest(
      appBar: CustomAppBar.coral(
        title: 'Title',
        subtitle: 'Step 1 of 2',
        leading: CustomFilledIconButton.leadingBlueLighter(onPressed: () {}),
      ),
      body: ScrollableContainer(
        child: MainContainer(
          child: Column(
            children: [
              CustomOutlinedButton.petrol(onPressed: () {}, label: 'label'),
              CustomOutlinedButton.petrolSmall(onPressed: () {}, label: 'label'),
              CustomOutlinedButton.petrolFullWidth(onPressed: () {}, label: 'label'),
              CustomOutlinedButton.blue(onPressed: () {}, label: 'label'),
              CustomOutlinedButton.blueSmall(onPressed: () {}, label: 'label'),
              CustomOutlinedButton.blueFullWidth(onPressed: () {}, label: 'label'),
              CustomOutlinedButton.orange(onPressed: () {}, label: 'label'),
              CustomOutlinedButton.orangeSmall(onPressed: () {}, label: 'label'),
              CustomOutlinedButton.orangeFullWidth(onPressed: () {}, label: 'label'),
              CustomOutlinedButton.coral(onPressed: () {}, label: 'label'),
              CustomOutlinedButton.coralSmall(onPressed: () {}, label: 'label'),
              CustomOutlinedButton.coralFullWidth(onPressed: () {}, label: 'label'),
              CustomOutlinedButton.green(onPressed: () {}, label: 'label'),
              CustomOutlinedButton.greenSmall(onPressed: () {}, label: 'label'),
              CustomOutlinedButton.greenFullWidth(onPressed: () {}, label: 'label'),
              CustomOutlinedButton.yellow(onPressed: () {}, label: 'label'),
              CustomOutlinedButton.yellowSmall(onPressed: () {}, label: 'label'),
              CustomOutlinedButton.yellowFullWidth(onPressed: () {}, label: 'label'),
            ],
          ),
        ),
      ),
    );
  }
}
