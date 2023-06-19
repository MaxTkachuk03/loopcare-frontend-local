import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/physical_program.dart';

class PhysicalActivitiesListItem extends StatelessWidget {
  final PhysicalProgram item;

  const PhysicalActivitiesListItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageIcon(
          AppIcons.checkmark,
          color: item.map(
            basic: (_) => AppColors.greenMid,
            dashboardPlaceholder: (_) => AppColors.greyMid,
          ),
        ),
        const SizedBox(width: 14.0),
        AutoSizeText(
          maxLines: 1,
          item.name,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w600,
              color: item.map(
                basic: (_) => AppColors.darkGreen,
                dashboardPlaceholder: (_) => AppColors.greyMid,
              )),
        ),
      ],
    );
  }
}
