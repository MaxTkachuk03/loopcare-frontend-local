import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/validators/age_validator.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_medical/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/presentation/birthday/widgets/birthdate_picker.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/utils/date_helpers.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';

class BirthdayField extends StatefulWidget {
  const BirthdayField({super.key});

  @override
  State<BirthdayField> createState() => _BirthdayFieldState();
}

class _BirthdayFieldState extends State<BirthdayField> {
  late DateTime value;

  @override
  void initState() {
    final bloc = context.read<PhysicalFitnessBloc>();

    value = bloc.state.birthday ?? DateTime.now();

    super.initState();
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
              const SizedBox(height: 100.0),
              CustomElevatedButton.blueFullWidth(
                onPressed: () => _onNextPressed(context),
                label: LocalizedTexts.next,
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
    final age = DateHelpers.calculateAge(value);

    if (!ageValidator(age)) {
      context.router.pushNamed(AppRoutes.checkFailedByAge);
      return;
    }

    final bloc = context.read<PhysicalFitnessBloc>();
    final medicalBloc = context.read<MedicalFitnessBloc>();

    bloc.add(PhysicalFitnessEvent.birthdayChanged(value));
    medicalBloc.add(MedicalFitnessEvent.handleBirthday(value));

    final physicalFitnessNavigationState = StepNavigationState.of(context);
    physicalFitnessNavigationState.onNextPage();
  }
}
