import 'package:intl/intl.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/widgets/bottom_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/validators/age_validator.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding/application/general/general_onboarding_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/medical_questions/medical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/application/physical_questions/physical_questions_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/physical_questions/views/birthday/widgets/birthdate_picker.dart';
import 'package:loopcare_frontend/features/onboarding/utils/date_helpers.dart';

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
                  DateFormat.yMMMMd(Localizations.localeOf(context).toString()).format(value),
                  style: context.textTheme.headlineLarge,
                ),
              ),
              const SizedBox(height: 160.0),
            ],
          ),
        ),
        BottomBar(
          backgroundColor: AppColors.yellowLightest,
          child: CustomElevatedButton.blueFullWidth(
            onPressed: () => _onNextPressed(context),
            label: LocalizedTexts.next.tr(),
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
