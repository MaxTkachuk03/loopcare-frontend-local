import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/presentation/medical_question_wrap.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/progress_bar.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class MedicinesPage extends StatefulWidget {
  const MedicinesPage({super.key});

  @override
  State<MedicinesPage> createState() => _MedicinesPageState();
}

class _MedicinesPageState extends State<MedicinesPage> {
  final _formKey = GlobalKey();

  final List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  void _onNextPressed(BuildContext context) {
    List<String> medicines = [];

    for (var c in controllers) {
      if (c.text.isNotEmpty) medicines.add(c.text.trim());
    }

    context.read<MedicalFitnessBloc>().add(MedicalFitnessEvent.medicinesChanged(medicines));

    final medicalFitnessNavigationState = StepNavigationState.of(context);

    medicalFitnessNavigationState.onNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return MedicalQuestionWrap(
      child: CustomScaffold.blueLightest(
        appBar: CustomAppBar.blue(
          title: LocalizedTexts.medicalIntroTitle.tr(),
          subtitle: LocalizedTexts.stepCounter.tr(args: ['2', '16']),
          leading: CustomFilledIconButton.leadingBlueLighter(),
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ProgressBar.coral(backgroundColor: AppColors.blueRegular),
                    MainContainer(
                      child: Column(
                        children: [
                          const SizedBox(height: 80.0),
                          CustomText.bitter600(
                            '${LocalizedTexts.medicinesTitle.tr()}?',
                            textAlign: TextAlign.center,
                            style: context.textTheme.displayMedium,
                          ),
                          const SizedBox(height: 28.0),
                          Form(
                            key: _formKey,
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (BuildContext context, int i) => CustomTextField(
                                controller: controllers[i],
                                hintText: LocalizedTexts.medicinesPlaceholder.tr(),
                              ),
                              separatorBuilder: (_, __) => const SizedBox(height: 28),
                            ),
                          ),
                          const SizedBox(height: 36.0),
                        ],
                      ),
                    ),
                  ],
                ),
                MainContainer(
                  child: Column(
                    children: [
                      Builder(
                        builder: (context) => CustomElevatedButton.coralFullWidth(
                          label: LocalizedTexts.next,
                          onPressed: () => _onNextPressed(context),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var element in controllers) {
      element.dispose();
    }

    super.dispose();
  }
}
