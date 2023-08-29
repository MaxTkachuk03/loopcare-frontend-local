import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class GroupedSignedMightBeCancelled extends StatelessWidget {
  final int number;

  const GroupedSignedMightBeCancelled({
    Key? key,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          const Image(image: AppIcons.exclamationPoint, width: 16, height: 16),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(LocalizedTexts.noMinMemberCount.translation,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.orangeDark))
                .tr(
              namedArgs: {
                'number': number.toString(),
              },
            ),
          ),
        ],
      ),
    );
  }
}
