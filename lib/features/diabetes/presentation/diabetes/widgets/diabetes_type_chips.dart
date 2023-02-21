import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/features/diabetes/application/diabetes_bloc.dart';
import 'package:loopcare_frontend/features/diabetes/application/dto/diabetes_type.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/string_extensions.dart';

class DiabetesTypeChips extends StatefulWidget {
  const DiabetesTypeChips({Key? key}) : super(key: key);

  @override
  State<DiabetesTypeChips> createState() => _DiabetesTypeChipsState();
}

class _DiabetesTypeChipsState extends State<DiabetesTypeChips> {
  @override
  void initState() {
    context.read<DiabetesBloc>().add(const DiabetesEvent.fetchDiabetesTypes());

    super.initState();
  }

  void _onSelectedDiabetesTypeHandler(DiabetesType diabetesType) {
    context
        .read<DiabetesBloc>()
        .add(DiabetesEvent.setDiabetesType(diabetesType));

    if (diabetesType.name == 'no') {
      context.router.pushNamed(AppRoutes.diabetesSummary);

      return;
    }

    context.router.pushNamed(AppRoutes.diabetesDisclaimer);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiabetesBloc, DiabetesState>(
      builder: (BuildContext context, state) {
        return Column(
          children: state.diabetesTypes
              .map((DiabetesType diabetesType) => Column(
                    children: [
                      AppChoiceChip(
                        label: diabetesType.name.capitalizeOnlyFirstLetter(),
                        selected: state.selectedType?.id == diabetesType.id,
                        value: diabetesType,
                        onSelected: _onSelectedDiabetesTypeHandler,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 8.0)
                    ],
                  ))
              .toList(),
        );
      },
    );
  }
}
