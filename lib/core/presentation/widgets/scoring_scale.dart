import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_assesment/widgets/regular_cell.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_assesment/widgets/selected_cell.dart';

class ScoringScale extends StatelessWidget {
  final int? selectedScore;
  final void Function(int tabIndex) onScoreTap;

  const ScoringScale({Key? key, required this.selectedScore, required this.onScoreTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            10,
            (index) => index + 1 == selectedScore
                ? SelectedCell(index: index + 1)
                : RegularCell(
                    index: index + 1,
                    onPress: onScoreTap,
                  ),
          ),
        ),
      ),
    );
  }
}
