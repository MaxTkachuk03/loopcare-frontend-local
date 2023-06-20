import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/education/presentation/utils/format_duration.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';

part 'program_card.freezed.dart';

@freezed
class ProgramCardSize with _$ProgramCardSize {
  const factory ProgramCardSize.small() = Small;

  const factory ProgramCardSize.large() = Large;
}

class ProgramCard extends StatelessWidget {
  final ProgramCardSize size;
  final PhysicalProgram program;

  const ProgramCard({Key? key, required this.size, required this.program}) : super(key: key);

  double get _imageWidth {
    return size.map(
      small: (_) => 104,
      large: (_) => 130,
    );
  }

  double get _cardHeight {
    return size.map(
      small: (_) => 190,
      large: (_) => 270,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _cardHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: const EdgeInsets.only(right: 34.0),
          color: AppColors.white,
          child: Row(
            children: [
              Container(
                width: _imageWidth,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AppImages.testProgram,
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              const SizedBox(
                width: 24.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      program.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                            program.difficultyName.toUpperCase(),
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
                          formatDuration(program.duration),
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      program.placeName.toUpperCase(),
                      style: const TextStyle(
                        fontSize: ThemeConstants.fontSize12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      program.typeName.toUpperCase(),
                      style: const TextStyle(
                        fontSize: ThemeConstants.fontSize12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      '${LocalizedTexts.equipment}: ${program.equipment}',
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                    Text(
                      '${LocalizedTexts.targetMuscles}: ${program.targetMuscles}',
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodySmall,
                    ).tr(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
