import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/category_label/category_label.dart';
import 'package:loopcare_frontend/core/presentation/clippers/education_clipper.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class NoGroup extends StatelessWidget {
  const NoGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<TopicsBloc, TopicsState>(
          builder: (context, state) {
            final startDate = state.data.signedGroupSessionStartTime ?? DateTime.now();
            final endDate = state.data.signedGroupSessionsEndTime ?? DateTime.now();

            final day = startDate.toDateFormat;
            final startTime = startDate.toTimeFormat;
            final endTime = endDate.toTimeFormat;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomText.bitter600(
                  LocalizedTexts.comingUpThisWeek.tr(),
                  style: context.textTheme.bodyLarge,
                ),
                const SizedBox(height: 18),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: AppColors.blueLighter, style: BorderStyle.solid),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Row(
                    children: [
                      ClipPath(
                        clipper: ImageClipper(),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          child: SizedBox(
                            width: 135,
                            height: 180,
                            child: NetworkImageWithCache(url: state.data.thisWeekTopicsImage),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, right: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10.0),
                              CategoryLabel(
                                label: LocalizedTexts.completed.tr(),
                                color: AppColors.coralRegular,
                              ),
                              const SizedBox(height: 10.0),
                              CustomText.w700(
                                state.data.weekTopicName,
                                style: context.textTheme.bodySmall,
                              ),
                              const SizedBox(height: 10.0),
                              CustomText.w400(
                                LocalizedTexts.dayFromTo.tr(
                                  {
                                    'day': day,
                                    'startTime': startTime,
                                    'endTime': endTime,
                                  },
                                ),
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontSize: ThemeConstants.fontSize12,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                CustomText.w400(LocalizedTexts.nextWeekTopic.tr(),
                    style: context.textTheme.bodyMedium),
              ],
            );
          },
        ),
      ],
    );
  }
}
