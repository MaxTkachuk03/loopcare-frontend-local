import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/reflections/domain/reflection.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';

class ReflectionListItem extends StatelessWidget {
  final Reflection item;
  final bool fromDashboard;
  final bool isPast;

  const ReflectionListItem({
    super.key,
    required this.item,
    required this.fromDashboard,
    this.isPast = false,
  });

  Color get _checkIconColor => item.isComplete ? AppColors.greenRegular : AppColors.greyMid;

  void _onItemPressedHandler(BuildContext context) => context.router
      .push(ReflectionsIntroRoute(reflectionItem: item, fromDashboard: fromDashboard));

  String get _subTitle => item.isComplete
      ? LocalizedTexts.completedOn.tr(
          namedArgs: {'date': item.completedAt?.dayWithMonthWithoutLeadingZero ?? ''},
        )
      : LocalizedTexts.completeBefore.tr(
          namedArgs: {'date': item.unlockedAt?.plusWeekShortVersion ?? ''},
        );

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => _onItemPressedHandler(context),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check, size: 20, color: _checkIconColor),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText.w600(item.title, style: context.textTheme.bodySmall),
                          if (!item.isCompletedMoreThanWeekAgo || !isPast)
                            CustomText.w400(_subTitle, style: context.textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12.0),
              const Icon(Icons.chevron_right_rounded, color: AppColors.blueDarker, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
