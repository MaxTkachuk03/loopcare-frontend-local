import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/education/presentation/utils/format_duration.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';

class ProgramCard extends StatelessWidget {
  final PhysicalProgram program;

  const ProgramCard({Key? key, required this.program}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 34.0),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 26.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Body weight essentials',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontFamily: ThemeConstants.bitterFontFamily,
                    ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                    decoration: const BoxDecoration(
                      color: AppColors.darkGreen,
                      borderRadius: BorderRadius.all(
                        Radius.circular(3.0),
                      ),
                    ),
                    child: Text(
                      'Easy'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: ThemeConstants.fontSize10,
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  AppIcons.clock,
                  const SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    formatDuration(300),
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                'Home'.toUpperCase(),
                style: const TextStyle(
                  fontSize: ThemeConstants.fontSize12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Strength'.toUpperCase(),
                style: const TextStyle(
                  fontSize: ThemeConstants.fontSize12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                '${LocalizedTexts.equipment}: none',
                style: Theme.of(context).textTheme.bodySmall,
              ).tr(),
              Text(
                '${LocalizedTexts.targetMuscles}: core',
                style: Theme.of(context).textTheme.bodySmall,
              ).tr(),
            ],
          )
        ],
      ),
    );
  }
}
