import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class SubscriptionWidget extends StatelessWidget {
  const SubscriptionWidget({super.key, required this.streamType});

  final RiverModuleStreamType streamType;

  void _toSubscriptions(BuildContext context) {
    context.router.pushNamed(AppRoutes.subscriptionV2);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _toSubscriptions(context),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        height: 84.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: streamType.regularColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIcons.subscriptionsWidgetIcon,
            const SizedBox(width: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: streamType.offRegularColor,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                          color: streamType.offRegularColor, blurRadius: 20)
                    ],
                  ),
                  child: CustomText.w500(
                    LocalizedTexts.membersOnly.tr(),
                    style: context.textTheme.labelMedium
                        ?.copyWith(color: AppColors.white),
                  ),
                ),
                CustomText.w600(
                  LocalizedTexts.subscribeToUnlock.tr(),
                  style: context.textTheme.bodySmall
                      ?.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
