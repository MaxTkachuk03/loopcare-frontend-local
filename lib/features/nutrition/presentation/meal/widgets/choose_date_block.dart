import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class ChooseDateBlock extends StatelessWidget {
  final void Function(BuildContext context)? onTap;
  final String date;

  const ChooseDateBlock({
    super.key,
    this.onTap,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap == null ? null : () => onTap?.call(context),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: AppColors.yellowLight)),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: IconButton(
                    splashRadius: 20,
                    padding: EdgeInsets.zero,
                    iconSize: 22,
                    onPressed: null,
                    icon: Icon(
                      Icons.calendar_month,
                      color: AppColors.darkGreen,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocalizedTexts.thisMealPlannedFor.tr(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(overflow: TextOverflow.ellipsis),
                    ),
                    Text(
                      date,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                const ImageIcon(
                  size: 14.0,
                  AppIcons.arrow,
                  color: AppColors.darkGreen,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
