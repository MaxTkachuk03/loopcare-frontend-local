import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/self_help/application/dto/prefer_gender.dart';
import 'package:loopcare_frontend/features/self_help/application/self_help_bloc.dart';

class SelfHelpGenderPreferencesChips extends StatefulWidget {
  const SelfHelpGenderPreferencesChips({
    Key? key,
  }) : super(key: key);

  @override
  State<SelfHelpGenderPreferencesChips> createState() =>
      _SelfHelpGenderPreferencesChipsState();
}

class _SelfHelpGenderPreferencesChipsState
    extends State<SelfHelpGenderPreferencesChips> {
  @override
  void initState() {
    context
        .read<SelfHelpBloc>()
        .add(const SelfHelpEvent.fetchPreferGendersTypes());

    super.initState();
  }

  void _onSelectedTypeHandler(PreferGender preferGenderType) {
    context
        .read<SelfHelpBloc>()
        .add(SelfHelpEvent.setAccountPreferGender(preferGenderType));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelfHelpBloc, SelfHelpState>(
      builder: (BuildContext context, state) {
        return Column(
          children: state.preferedGenderTypes
              .map(
                (PreferGender preferedGenderType) => Column(
                  children: [
                    AppChoiceChip(
                      label:
                          preferedGenderType.name.capitalizeOnlyFirstLetter(),
                      selected: state.selectedType?.id == preferedGenderType.id,
                      value: preferedGenderType,
                      onSelected: _onSelectedTypeHandler,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 8.0)
                  ],
                ),
              )
              .toList(),
        );
      },
    );
  }
}
