import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_assesment/widgets/regular_cell.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/program_assesment/widgets/selected_cell.dart';

class AssesmentBlock extends StatefulWidget {
  final int? score;
  final void Function(int score) onScoreChange;

  const AssesmentBlock({
    Key? key,
    required this.score,
    required this.onScoreChange,
  }) : super(key: key);

  @override
  State<AssesmentBlock> createState() => _AssesmentBlockState();
}

class _AssesmentBlockState extends State<AssesmentBlock> {
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 27.0,
        horizontal: 24.0,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            LocalizedTexts.howHard.translation,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            height: 65,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  10,
                  (index) => index == selectedIndex
                      ? SelectedCell(index: index + 1)
                      : RegularCell(
                          index: index + 1,
                          onPress: (int tabIndex) {
                            _onCellTap(tabIndex - 1);
                          },
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocalizedTexts.veryEasy.translation,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.greyMid,
                    ),
              ),
              Text(
                LocalizedTexts.veryHard.translation,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.greyMid,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
        ],
      ),
    );
  }

  void _onCellTap(int index) {
    setState(() {
      selectedIndex = index;
      widget.onScoreChange(index);
    });
  }
}
