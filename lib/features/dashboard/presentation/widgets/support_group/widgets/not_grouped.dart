import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class NotGrouped extends StatelessWidget {
  const NotGrouped({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onJoinGroupTap(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            LocalizedTexts.joinAGroup,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.blueDark,
                  fontWeight: FontWeight.w600,
                ),
          ).tr(),
          const ImageIcon(
            AppIcons.arrow,
            color: AppColors.greyLabel,
          ),
        ],
      ),
    );
  }

  _onJoinGroupTap(BuildContext context) {
    context.router.pushNamed(AppRoutes.groupPreferences);
  }
}
