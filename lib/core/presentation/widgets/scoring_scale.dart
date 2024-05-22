import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_assesment/widgets/regular_cell.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_assesment/widgets/selected_cell.dart';

class ScoringScale extends StatelessWidget {
  final int? selectedScore;
  final void Function(int tabIndex) onScoreTap;
  final int? scaleSize;
  final List<String>? labels;
  final Color? borderColor;
  final Color? divColor;
  final Color? textColor;
  final Color selectedColor;

  const ScoringScale({
    super.key,
    required this.selectedScore,
    required this.onScoreTap,
    required this.selectedColor,
    this.scaleSize,
    this.textColor,
    this.labels,
    this.borderColor,
    this.divColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        scaleSize ?? 10,
        (index) => index == selectedScore
            ? Expanded(
                child: SelectedCell(
                  textColor: textColor,
                  selectedColor: selectedColor,
                  index: index,
                  label: labels?.elementAt(index),
                ),
              )
            : Expanded(
                child: RegularCell(
                  index: index,
                  textColor: textColor,
                  onPress: onScoreTap,
                  scaleSize: scaleSize,
                  label: labels?.elementAt(index),
                  borderColor: borderColor,
                  divColor: divColor,
                ),
              ),
      ),
    );
  }
}
