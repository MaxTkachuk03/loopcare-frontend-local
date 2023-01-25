import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/check_failed_bmi/check_failed_bmi_page.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/check_passed/check_passed_page.dart';

class PhysicalCheckResultPage extends StatelessWidget {
  const PhysicalCheckResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhysicalFitnessBloc, PhysicalFitnessState>(
      builder: (BuildContext context, state) {
        return state.isCompletedSuccessfully
            ? const CheckPassedPage()
            : const CheckFailedBmiPage();
      },
    );
  }
}
