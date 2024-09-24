import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/physical_programs/widgets/program_card.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

@RoutePage()
class PhysicalProgramsPage extends StatelessWidget {
  const PhysicalProgramsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhysicalProgramsBloc, PhysicalProgramsState>(
      builder: (context, state) {
        return state.maybeMap(
          error: (errorState) {
            final error = errorState.data.error;

            return ErrorScreen(
              error: error!,
              onButtonPressed: () => context
                  .read<PhysicalProgramsBloc>()
                  .add(const PhysicalProgramsEvent.getAllPrograms()),
            );
          },
          loading: (_) => CustomScaffold.yellowLightest(
            appBar: CustomAppBar.yellow(title: state.data.programType.title),
            body: const Loader(),
          ),
          orElse: () => CustomScaffold.yellowLightest(
            appBar: CustomAppBar.yellow(
              title: state.data.programType.title,
              leading: CustomFilledIconButton.leadingYellowLighter(),
            ),
            body: CustomSafeArea(
              child: ScrollableContainer(
                child: MainContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20.0),
                      CustomText.bitter600(
                        LocalizedTexts.selectYourProgram.tr(),
                        style: context.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 20.0),
                      if (state.data.getSelectedPrograms.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText.bitter600(
                              LocalizedTexts.recommended.tr(),
                              style: context.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 20.0),
                            ProgramCard(
                              program: state.data.getSelectedPrograms.first,
                              bgColor: AppColors.yellowRegular,
                              borderColor: AppColors.yellowRegular,
                              padding: const EdgeInsets.all(4.0),
                              size: const ProgramCardSize.small(),
                              onlyView: false,
                            ),
                            const SizedBox(height: 16.0),
                            if (state.data.getAlternativePrograms.isNotEmpty)
                              CustomText(
                                LocalizedTexts.alternatives.tr(),
                                style: context.textTheme.bodySmall,
                              ),
                            if (state.data.getAlternativePrograms.isNotEmpty)
                              const SizedBox(height: 16.0),
                          ],
                        ),
                      if (state.data.getAlternativePrograms.isNotEmpty)
                        ListView.builder(
                          itemCount: state.data.getAlternativePrograms.toList().length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, index) => ProgramCard(
                            bgColor: AppColors.white,
                            borderColor: AppColors.yellowRegular,
                            program: state.data.getAlternativePrograms.toList()[index],
                            size: const ProgramCardSize.small(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
