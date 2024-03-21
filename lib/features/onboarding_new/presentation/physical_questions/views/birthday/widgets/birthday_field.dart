import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/validators/age_validator.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/medical_questions/medical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/application/physical_questions/physical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding_new/presentation/physical_questions/views/birthday/widgets/birthdate_picker.dart';
import 'package:loopcare_frontend/features/onboarding_new/utils/date_helpers.dart';

class BirthdayField extends StatefulWidget {
  const BirthdayField({super.key});

  @override
  State<BirthdayField> createState() => _BirthdayFieldState();
}

class _BirthdayFieldState extends State<BirthdayField> {
  late DateTime value;

  @override
  void initState() {
    super.initState();
    value = context.read<PhysicalQuestionsBloc>().state.birthday ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainContainer(
          child: Column(
            children: [
              SizedBox(
                child: CustomText.bitter500(
                  // TODO DateFormat.yMMMMd(Intl.getCurrentLocale()).format(value), - return when localization translations will be finished
                  DateFormat.yMMMMd('en_EN').format(value),
                  style: context.textTheme.headlineLarge,
                ),
              ),
              const SizedBox(height: 160.0),
              CustomElevatedButton.blueFullWidth(
                onPressed: () => _onNextPressed(context),
                label: LocalizedTexts.next.tr(),
              ),
              const SizedBox(height: 70.0),
            ],
          ),
        ),
        BirthDatePicker(value: value, selectedDate: selectedDate),
      ],
    );
  }

  void selectedDate(DateTime selectedDate) {
    setState(() => value = selectedDate);
  }

  _onNextPressed(BuildContext context) {
    final ageValid = ageValidator(DateHelpers.calculateAge(value));

    context.read<PhysicalQuestionsBloc>().add(PhysicalQuestionsEvent.birthdayChanged(value));
    context.read<MedicalQuestionsBloc>().add(MedicalQuestionsEvent.handleBirthday(value));
    context.read<GeneralOnboardingBloc>().add(GeneralOnboardingEvent.nextStep(excluded: !ageValid));
  }
}
