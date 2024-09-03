import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/domain/analytics/analytics_events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/analytics_service.dart';
import 'package:loopcare_frontend/core/presentation/clippers/education_clipper.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_utils.dart';
import 'package:loopcare_frontend/features/education/presentation/education_page/widgets/category_label.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_programs_bloc.dart';
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
  final Color? bgColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final bool onlyView;

  const ProgramCard({
    super.key,
    required this.size,
    required this.program,
    this.bgColor,
    this.borderColor,
    this.padding,
    this.onlyView = false,
  });

  factory ProgramCard.onlyView({
    required ProgramCardSize size,
    required PhysicalProgram program,
    Color? bgColor,
    Color? borderColor,
    EdgeInsetsGeometry? padding,
  }) =>
      ProgramCard(
        size: size,
        program: program,
        bgColor: bgColor,
        borderColor: borderColor,
        padding: padding,
        onlyView: true,
      );

  double get _cardHeight {
    return size.map(
      small: (_) => 200,
      large: (_) => 270,
    );
  }

  Widget _categoryLabel(String category) {
    switch (category) {
      case 'easy':
        return CategoryLabel.difficultyEasy();
      case 'medium':
        return CategoryLabel.difficultyMedium();
      case 'hard':
        return CategoryLabel.difficultyHard();
    }

    return CategoryLabel.difficultyEasy();
  }

  @override
  Widget build(BuildContext context) {
    final image = program.image;

    return InkWell(
      onTap: onlyView ? null : () => _onTap(context),
      child: SizedBox(
        height: _cardHeight,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: borderColor ?? AppColors.white,
              width: 2.0,
            ),
          ),
          color: bgColor ?? AppColors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (image != null)
                Expanded(
                  flex: 2,
                  child: ClipPath(
                    clipper: ImageClipper(),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: NetworkImageWithCache(url: image),
                    ),
                  ),
                ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText.bitter700(
                      program.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        _categoryLabel(program.difficultyName),
                        const SizedBox(width: 16.0),
                        AppIcons.clock,
                        const SizedBox(width: 4.0),
                        CustomText.w600(
                          formatSecondsToDurationString(program.duration, alwaysShowSeconds: true),
                          style: context.textTheme.bodySmall
                              ?.copyWith(fontSize: ThemeConstants.fontSize10),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          CustomText.w700(
                            program.placeName.toUpperCase(),
                            style: context.textTheme.bodySmall
                                ?.copyWith(fontSize: ThemeConstants.fontSize12),
                          ),
                          const VerticalDivider(
                            color: AppColors.blueDarker,
                            thickness: 1.0,
                          ),
                          CustomText.w700(
                            program.typeName.toUpperCase(),
                            style: context.textTheme.bodySmall
                                ?.copyWith(fontSize: ThemeConstants.fontSize12),
                          ),
                        ],
                      ),
                    ),
                    CustomText.w400(
                      LocalizedTexts.equipment.tr({
                        'equipment': program.equipment,
                      }),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontSize: ThemeConstants.fontSize12),
                    ),
                    CustomText.w400(
                      LocalizedTexts.targetMuscles.tr({
                        'targetMuscles': program.targetMuscles,
                      }),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontSize: ThemeConstants.fontSize12),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onTap(BuildContext context) {
    context
      ..router.push(ProgramDetailsRoute(program: program))
      ..read<PhysicalProgramsBloc>().add(PhysicalProgramsEvent.setCurrentProgram(program));

    const AnalyticsEventService().logPhysicalProgramEvent(
      AnalyticsEvents.physicalProgramsScreen,
      program,
    );
  }
}
