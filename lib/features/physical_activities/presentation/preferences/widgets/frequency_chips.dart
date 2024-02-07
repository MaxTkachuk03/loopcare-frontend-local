import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/domain/physical_activities_frequency.dart';
import 'package:loopcare_frontend/core/presentation/choice_chip/custom_choice_chip.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/physical_activities_preferences_bloc.dart';

class FrequencyChips extends StatefulWidget {
  final bool _profileInvoke;

  const FrequencyChips.green({super.key}) : _profileInvoke = false;

  const FrequencyChips.coral({super.key}) : _profileInvoke = true;

  @override
  State<FrequencyChips> createState() => _FrequencyChipsState();
}

class _FrequencyChipsState extends State<FrequencyChips> {
  PhysicalActivitiesFrequency? _selectedValue;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<PhysicalActivitiesPreferencesBloc>();
    if (bloc.state.data.isFrequencySet) {
      _selectedValue = bloc.state.data.trainingFrequency;
    }
  }

  void _onSelectedHandler(PhysicalActivitiesFrequency value) {
    setState(() {
      _selectedValue = value;
    });

    final bloc = context.read<PhysicalActivitiesPreferencesBloc>();
    bloc.add(PhysicalActivitiesPreferencesEvent.setFrequency(value));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: PhysicalActivitiesFrequency.values
          .map(
            (PhysicalActivitiesFrequency value) => Column(
              children: [
                widget._profileInvoke
                    ? CustomChoiceChip.coral(
                        label: value.label,
                        selected: value == _selectedValue,
                        value: value,
                        action: value.recommended
                            ? AutoSizeText(
                                LocalizedTexts.recommended.tr(),
                                textAlign: TextAlign.end,
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : null,
                        onSelected: _onSelectedHandler,
                      )
                    : CustomChoiceChip.green(
                        label: value.label,
                        selected: value == _selectedValue,
                        value: value,
                        action: value.recommended
                            ? AutoSizeText(
                                LocalizedTexts.recommended.tr(),
                                textAlign: TextAlign.end,
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : null,
                        onSelected: _onSelectedHandler,
                      ),
                const SizedBox(height: 8.0),
              ],
            ),
          )
          .toList(),
    );
  }
}
