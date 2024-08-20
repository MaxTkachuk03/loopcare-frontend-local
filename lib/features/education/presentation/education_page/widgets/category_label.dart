import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/program_difficulty.dart';
import 'package:loopcare_frontend/features/river/infrastructure/river_module_stream_type.dart';

class CategoryLabel extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;

  const CategoryLabel({
    super.key,
    required this.label,
    required this.color,
    this.textColor = AppColors.white,
  });

  factory CategoryLabel.psychology() =>
      CategoryLabel(label: RiverModuleStreamType.psychology.label, color: AppColors.petrolRegular);

  factory CategoryLabel.nutrition() =>
      CategoryLabel(label: RiverModuleStreamType.nutrition.label, color: AppColors.greenRegular);

  factory CategoryLabel.physicalActivity() => CategoryLabel(
      label: RiverModuleStreamType.physicalActivity.label, color: AppColors.yellowRegular);

  factory CategoryLabel.medical() =>
      CategoryLabel(label: RiverModuleStreamType.medical.label, color: AppColors.coralRegular);

  factory CategoryLabel.community() =>
      CategoryLabel(label: RiverModuleStreamType.community.label, color: AppColors.orangeRegular);

  factory CategoryLabel.reflection() =>
      CategoryLabel(label: LocalizedTexts.reflection.tr(), color: AppColors.petrolRegular);

  factory CategoryLabel.difficultyEasy() =>
      CategoryLabel(label: ProgramDifficulty.easy.label, color: AppColors.petrolRegular);

  factory CategoryLabel.difficultyMedium() =>
      CategoryLabel(label: ProgramDifficulty.medium.label, color: AppColors.yellowRegular);

  factory CategoryLabel.difficultyHard() =>
      CategoryLabel(label: ProgramDifficulty.hard.label, color: AppColors.red);

  factory CategoryLabel.groupSession() =>
      CategoryLabel(label: LocalizedTexts.groupSession.tr(), color: AppColors.petrolRegular);

  factory CategoryLabel.buddy() =>
      CategoryLabel(label: LocalizedTexts.buddy.tr(), color: AppColors.coralRegular);

  factory CategoryLabel.smartGoals({required String label}) =>
      CategoryLabel(label: label, color: AppColors.greenRegular, textColor: AppColors.blueDarker);

  factory CategoryLabel.smartGoalNew() => CategoryLabel(
        label: LocalizedTexts.smartGoalNewLabel.tr(),
        color: AppColors.blueRegular,
        textColor: AppColors.blueLightest,
      );

  factory CategoryLabel.maintenance() => CategoryLabel(
        label: LocalizedTexts.maintenanceLabel.tr().toUpperCase(),
        color: AppColors.coralRegular,
        textColor: AppColors.white,
      );

  factory CategoryLabel.news() => CategoryLabel(
        label: LocalizedTexts.news.tr().toUpperCase(),
        color: AppColors.lq3,
        textColor: AppColors.white,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0), color: color),
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
      child: CustomText.w600(
        label.toUpperCase(),
        style: context.textTheme.bodyMedium?.copyWith(
          fontSize: ThemeConstants.fontSize10,
          color: textColor,
        ),
      ),
    );
  }
}
