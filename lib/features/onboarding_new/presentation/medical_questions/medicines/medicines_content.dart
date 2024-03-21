import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/medical_questions/medical_questions_bloc.dart';

class MedicinesContent extends StatefulWidget {
  const MedicinesContent({super.key});

  @override
  State<MedicinesContent> createState() => _MedicinesContentState();
}

class _MedicinesContentState extends State<MedicinesContent> {
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

    for (final c in controllers) {
      if (c.text.isNotEmpty) medicines.add(c.text.trim());
    }

    context.read<MedicalQuestionsBloc>().add(MedicalQuestionsEvent.medicinesChanged(medicines));
    context.read<GeneralOnboardingBloc>().add(const GeneralOnboardingEvent.nextStep());
  }

  @override
  void dispose() {
    for (final element in controllers) {
      element.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 80.0),
              CustomText.bitter600(
                '${LocalizedTexts.medicinesTitle.tr()}?',
                style: context.textTheme.displayMedium,
              ),
              const SizedBox(height: 28.0),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: controllers
                      .map((controller) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: CustomTextField(
                            controller: controller,
                            hintText: LocalizedTexts.medicinesPlaceholder.tr(),
                            maxLength: 30,
                          ),
                        ))
                      .toList(),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 42.0),
            child: CustomElevatedButton.coralFullWidth(
              label: LocalizedTexts.next.tr(),
              onPressed: () => _onNextPressed(context),
            ),
          ),
        ],
      ),
    );
  }
}
