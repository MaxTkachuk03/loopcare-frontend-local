import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class GroupedJoinSession extends StatelessWidget {
  const GroupedJoinSession({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8.0,
        ),
        InkWell(
          onTap: () => _onPressed(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: AppColors.blueDark,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocalizedTexts.joinSession,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ).tr(),
                const ImageIcon(
                  AppIcons.arrow,
                  color: AppColors.white,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  _onPressed(BuildContext context) {
    context.router.pushNamed(AppRoutes.sessionWaitingRoom);
  }
}
