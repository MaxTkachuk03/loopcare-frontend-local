import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

class ProteinDegreeBlock extends StatelessWidget {
  final double? value;
  final void Function({required int tabIndex}) onPress;
  final bool showArrow;

  const ProteinDegreeBlock({
    Key? key,
    this.value,
    required this.onPress,
    required this.showArrow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NutritionInstructionsBloc, NutritionInstructionsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          loaded: (state) {
            final currentProteinDegreeItem = state.data.getProteinDegreeItem(value);

            if (state.data.proteinDegreeValues.isEmpty || currentProteinDegreeItem == null) {
              return const SizedBox();
            }

            final proteinDegreeValue = value != null ? '${value?.round()}%' : '-';

            return GestureDetector(
              onTap: () => _onItemPressed(context),
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocalizedTexts.proteinDegree.translation.toUpperCase(),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 12.0,
                              ),
                        ),
                        Text(
                          proteinDegreeValue,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        if (value != null)
                          Text(
                            currentProteinDegreeItem.label.capitalizeOnlyFirstLetter(),
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontSize: 14.0,
                                ),
                          ),
                      ],
                    ),
                    if (showArrow)
                      const SizedBox(
                        width: 8.0,
                      ),
                    if (showArrow)
                      const SizedBox(
                        width: 10,
                        height: 14,
                        child: ImageIcon(
                          AppIcons.arrow,
                          color: AppColors.darkGreen,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  _onItemPressed(BuildContext context) {
    onPress(tabIndex: 1);
  }
}
