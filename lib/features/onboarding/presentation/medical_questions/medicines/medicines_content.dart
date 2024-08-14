import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/medical_questions/medical_questions_bloc.dart';

class MedicinesContent extends StatefulWidget {
  const MedicinesContent({super.key});

  @override
  State<MedicinesContent> createState() => _MedicinesContentState();
}

class _MedicinesContentState extends State<MedicinesContent> {
  final _formKey = GlobalKey();

  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void initState() {
    super.initState();
    _setupMedicines();
  }

  @override
  void dispose() {
    for (final element in _controllers) {
      element.dispose();
    }

    super.dispose();
  }

  void _onNextPressed(BuildContext context) {
    List<String> medicines = [];

    for (final c in _controllers) {
      if (c.text.isNotEmpty) medicines.add(c.text.trim());
    }

    context.read<MedicalQuestionsBloc>().add(MedicalQuestionsEvent.medicinesChanged(medicines));
    context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.nextStep());
  }

  void _setupMedicines() {
    final medicines = context.read<MedicalQuestionsBloc>().state.medicines;

    for (int i = 0; i < medicines.length; i++) {
      _controllers[i].text = medicines[i];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomPlacedButton.coralLightest(
      body: MainContainer(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            const SizedBox(height: 50.0),
            CustomText.bitter600(
              '${LocalizedTexts.medicinesTitle.tr()}?',
              style: context.textTheme.displayMedium,
            ),
            const SizedBox(height: 28.0),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _controllers.map((c) {
                  final isLast = _controllers.last == c;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: CustomTextField(
                      controller: c,
                      hintText: LocalizedTexts.medicinesPlaceholder.tr(),
                      textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
                      maxLength: 30,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      button: CustomElevatedButton.blueFullWidth(
        label: LocalizedTexts.next.tr(),
        onPressed: () => _onNextPressed(context),
      ),
    );
  }
}
