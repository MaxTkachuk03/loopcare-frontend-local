import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/allocated_to_group.dart';

class GroupPreferencesPage extends StatelessWidget {
  const GroupPreferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlueAppBar(
        title: LocalizedTexts.groupPreferences.translation,
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: AllocatedToGroup(),
            ),
          ),
        ),
      ),
    );
  }
}
