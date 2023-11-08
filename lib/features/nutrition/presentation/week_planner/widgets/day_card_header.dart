import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';

class DayCardHeader extends StatelessWidget {
  final DateTime date;
  final VoidCallback onPressHandler;

  const DayCardHeader({
    Key? key,
    required this.date,
    required this.onPressHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          date.weekdayString,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.blueAppBar),
        ),
        if (date.isToday)
          Text(
            LocalizedTexts.today.translation.toUpperCase(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.blueAppBar,
                  fontWeight: FontWeight.w600,
                ),
          ),
        if (date.isAfter(DateTime.now()) && date.isBefore(DateTime.now().add(const Duration(days: 14))))
          Hexagon(
            width: 42,
            height: 42,
            borderRadius: 16,
            innerWidget: Container(
              color: AppColors.blueMid,
              child: IconButton(
                icon: const ImageIcon(
                  AppIcons.plus,
                  color: AppColors.white,
                  size: 12,
                ),
                onPressed: () => onPressHandler(),
              ),
            ),
          )
      ],
    );
  }
}
