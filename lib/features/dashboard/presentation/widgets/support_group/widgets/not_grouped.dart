import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class NotGrouped extends StatelessWidget {
  const NotGrouped({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onJoinGroupTap(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText.w600(
            LocalizedTexts.joinAGroup,
            style: context.textTheme.bodySmall,
          ),
          const ImageIcon(
            AppIcons.arrow,
            color: AppColors.blueDarker,
          ),
        ],
      ),
    );
  }

  _onJoinGroupTap(BuildContext context) {
    context.router.pushNamed(AppRoutes.groupPreferences);
  }
}
