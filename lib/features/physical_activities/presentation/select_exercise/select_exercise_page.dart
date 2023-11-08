import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/orange_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/chips_tab_bar.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/exercise_type.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/exercise_type_tab.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/select_exercise/widgets/custom_activity_tab.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/select_exercise/widgets/program_tab.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

AppConfig appConfig = getIt<AppConfig>();

class SelectExercisePage extends StatefulWidget {
  const SelectExercisePage({Key? key}) : super(key: key);

  @override
  State<SelectExercisePage> createState() => _SelectExercisePageState();
}

class _SelectExercisePageState extends State<SelectExercisePage> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<ExerciseTypeTab> tabs = [
    ExerciseTypeTab(
      text: '${appConfig.projectName} ${LocalizedTexts.program.translation}',
      type: ExerciseType.program,
    ),
    ExerciseTypeTab(
      text: LocalizedTexts.yourOwnActivity.translation,
      type: ExerciseType.custom,
    ),
  ];

  @override
  void initState() {
    super.initState();
    context.read<PhysicalProgramsBloc>().add(const PhysicalProgramsEvent.getAllPrograms());
    _tabController = TabController(
      vsync: this,
      length: tabs.length,
      animationDuration: Duration.zero,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: OrangeAppBar(title: LocalizedTexts.physicalActivity.translation),
        body: SafeArea(
          child: MainContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 32.0,
                ),
                const Text(
                  LocalizedTexts.selectYourExercise,
                  style: TextStyle(
                    fontSize: ThemeConstants.fontSize30,
                    fontFamily: ThemeConstants.bitterFontFamily,
                    fontWeight: FontWeight.w700,
                  ),
                ).tr(),
                const SizedBox(
                  height: 16.0,
                ),
                ChipsTabBar(
                  tabController: _tabController,
                  tabs: tabs.map((e) => Tab(text: e.text)).toList(),
                ),
                const SizedBox(height: 32.0),
                Flexible(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      ProgramTab(),
                      CustomActivityTab(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
