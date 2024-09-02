import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';

class BuddyNotAvailable extends StatelessWidget {
  const BuddyNotAvailable({super.key});

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
          const SizedBox(height: 18.0),
          CustomText.w400(
            LocalizedTexts.buddyNotAvailableSubTitle.tr(),
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
