import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/orange_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/program_type.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/physical_programs/widgets/program_carousel.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/physical_programs/widgets/program_card.dart';

class PhysicalProgramsPage extends StatelessWidget {
  const PhysicalProgramsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhysicalProgramsBloc, PhysicalProgramsState>(
      builder: (context, state) {
        if (state.data.isLoading) {
          return Scaffold(
            appBar: OrangeAppBar(title: state.data.programType.label),
            body: const SafeArea(
              child: Loader(),
            ),
          );
        }

        return Scaffold(
          appBar: OrangeAppBar(title: state.data.programType.label),
          body: SafeArea(
            child: ScrollableContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MainContainer(
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
                        if (state.data.programs.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 24.0,
                              ),
                              const Text(LocalizedTexts.recommended).tr(),
                              const SizedBox(
                                height: 16.0,
                              ),
                              ProgramCard(
                                program: state.data.programs.first,
                                size: const ProgramCardSize.large(),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              const Text(LocalizedTexts.alternatives).tr(),
                              const SizedBox(
                                height: 16.0,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  if (state.data.programs.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: SizedBox(
                        height: 220,
                        child: ProgramCarousel(
                          programs: state.data.programs.skip(1).toList(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
