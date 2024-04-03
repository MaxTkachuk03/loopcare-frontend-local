import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/tab_bar/custom_tab_bar.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/keyboard_state.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/exercise_type.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/exercise_type_tab.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/select_exercise/widgets/custom_activity_tab.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/select_exercise/widgets/program_tab.dart';
import 'package:loopcare_frontend/injection.dart';

AppConfig appConfig = getIt<AppConfig>();

class SelectExercisePage extends StatefulWidget {
  const SelectExercisePage({super.key});

  @override
  State<SelectExercisePage> createState() => _SelectExercisePageState();
}

class _SelectExercisePageState extends State<SelectExercisePage> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<ExerciseTypeTab> tabs = [
    ExerciseTypeTab(
      text: '${appConfig.projectName} ${LocalizedTexts.program.tr()}',
      type: ExerciseType.program,
    ),
    ExerciseTypeTab(
      text: LocalizedTexts.yourOwnActivity.tr(),
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
      child: CustomScaffold.yellowLightest(
        appBar: CustomAppBar.yellow(
          title: LocalizedTexts.physicalActivity.tr(),
          leading: CustomFilledIconButton.leadingYellowLighter(),
        ),
        body: CustomSafeArea(
          child: MainContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 28.0),
                CustomText.bitter600(
                  LocalizedTexts.selectYourProgram.tr(),
                  style: context.textTheme.displayMedium,
                ),
                const SizedBox(height: 20.0),
                CustomTabBar.yellow(
                  tabController: _tabController,
                  tabs: tabs.map((e) => Tab(text: e.text)).toList(),
                  onTap: () => dismissKeyboard(context),
                ),
                const SizedBox(height: 20.0),
                Expanded(
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
