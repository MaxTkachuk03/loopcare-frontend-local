import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/orange_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/physical_programs/widgets/program_carousel.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/physical_programs/widgets/program_card.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PhysicalProgramsPage extends StatelessWidget {
  const PhysicalProgramsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OrangeAppBar(title: 'ds'),
      body: MainContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 32.0,
            ),
            const Text(
              LocalizedTexts.chooseYourProgram,
              style: TextStyle(
                fontSize: ThemeConstants.fontSize30,
                fontFamily: ThemeConstants.bitterFontFamily,
                fontWeight: FontWeight.w700,
              ),
            ).tr(),
            SizedBox(
              height: 300,
              child: ProgramCarousel(
                programs: [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
