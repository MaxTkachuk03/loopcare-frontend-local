import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/medical_fitness/application/medical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/step_navigation_state.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/birthday/widgets/birthdate_picker.dart';
import 'package:loopcare_frontend/core/presentation/validators/age_validator.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/date_helpers.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BirthdayField extends StatefulWidget {
  const BirthdayField({Key? key}) : super(key: key);

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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: AutoSizeText(
                  maxLines: 1,
                  DateFormat.yMMMMd(Intl.getCurrentLocale()).format(value),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontFamily: ThemeConstants.bitterFontFamily,
                        fontSize: ThemeConstants.fontSize38,
                      ),
                ),
              ),
              const SizedBox(height: 120.0),
              ElevatedButton(
                onPressed: () => _onNextPressed(context),
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.orangeDark),
                    ),
                child: Text(
                  LocalizedTexts.next.tr(),
                ),
              ),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
        BirthDatePicker(
          value: value,
          selectedDate: selectedDate,
        ),
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
