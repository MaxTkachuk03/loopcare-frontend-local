import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class BuddyInvitationReject extends StatelessWidget {
  const BuddyInvitationReject({super.key});

  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText.bitter600(
            LocalizedTexts.buddyRejectTitle.tr(),
            style: context.textTheme.headlineSmall,
          ),
          const SizedBox(height: 18.0),
          CustomText.w400(
            LocalizedTexts.buddyRejectSubTitle.tr(),
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
