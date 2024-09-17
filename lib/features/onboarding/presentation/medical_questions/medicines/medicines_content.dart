import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/text_field/custom_text_field.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/scroll_controller_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/medical_questions/medical_questions_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

const _scrollValue = 64; // input height + sizedBox

class MedicinesContent extends StatefulWidget {
  const MedicinesContent({super.key});

  @override
  State<MedicinesContent> createState() => _MedicinesContentState();
}

class _MedicinesContentState extends State<MedicinesContent> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  final List<TextEditingController> _controllers = List.generate(5, (_) => TextEditingController());

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

    _scrollController.dispose();

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

  void _onEditingComplete() {
    FocusScope.of(context).nextFocus();

    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      return;
    }

    _scrollController.scrollWithEase600(_scrollController.position.pixels + _scrollValue);
  }

  @override
  Widget build(BuildContext context) {
    return BottomPlacedButton.coralLightest(
      body: MainContainer(
        child: Column(
          children: [
            const SizedBox(height: 50.0),
            CustomText.bitter600(
              LocalizedTexts.onboardingMedicinesTitle.tr(),
              style: context.textTheme.displayMedium,
            ),
            const SizedBox(height: 28.0),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView.separated(
                  controller: _scrollController,
                  itemCount: _controllers.length,
                  itemBuilder: (_, int i) {
                    final controller = _controllers[i];
                    final isLast = controller == _controllers.last;

                    return CustomTextField(
                      controller: controller,
                      hintText: LocalizedTexts.onboardingMedicinesPlaceholder.tr(),
                      textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
                      onEditingComplete: _onEditingComplete,
                      maxLength: 30,
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                ),
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
