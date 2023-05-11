import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_instructions/nutrition_instructions_bloc.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';

class ProteinBlock extends StatelessWidget {
  final double? value;
  final void Function({required int tabIndex}) onPress;

  const ProteinBlock({
    Key? key,
    this.value,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NutritionInstructionsBloc, NutritionInstructionsState>(
      builder: (BuildContext context, state) {
        return state.maybeMap(
          nutritionInstructions: (state) {
            final currentProteinDegreeItem = state.getProteinDegreeItem(value);

            if (state.proteinDegreeValues.isEmpty) return const SizedBox();

            return GestureDetector(
              onTap: _onItemPressed,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocalizedTexts.proteinDegree.translation.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: ThemeConstants.fontSize12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.greyLabel,
                            ),
                      ),
                      const SizedBox(width: 4.0),
                      const ImageIcon(
                        AppIcons.arrow,
                        color: AppColors.greyLabel,
                        size: 10,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  if (value != null)
                    Text(
                      (currentProteinDegreeItem?.label ?? '-')
                          .capitalizeOnlyFirstLetter(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 14.0,
                          ),
                    ),
                ],
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  _onItemPressed() {
    onPress(tabIndex: 1);
  }
}
