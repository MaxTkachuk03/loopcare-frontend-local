import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';

class BuddyNotAvailable extends StatefulWidget {
  const BuddyNotAvailable({super.key});

  @override
  State<BuddyNotAvailable> createState() => _BuddyNotAvailableState();
}

class _BuddyNotAvailableState extends State<BuddyNotAvailable> {
  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText.bitter600(
            LocalizedTexts.buddyNotAvailableTitle.tr(),
            style: context.textTheme.headlineSmall,
          ),
          CustomText.w400(
            LocalizedTexts.buddyNotAvailableSubTitle.tr(),
            style: context.textTheme.bodyMedium,
          ),
          const SizedBox(height: 17.0),
        ],
      ),
    );
  }
}
