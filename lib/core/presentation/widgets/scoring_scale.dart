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

  const ScoringScale({
    super.key,
    required this.selectedScore,
    required this.onScoreTap,
    this.scaleSize,
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
                  index: index,
                  label: labels?.elementAt(index),
                ),
              )
            : Expanded(
                child: RegularCell(
                  index: index,
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
