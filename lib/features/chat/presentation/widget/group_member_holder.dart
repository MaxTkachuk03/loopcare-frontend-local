import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/chat/domain/group_member.dart';

class GroupMemberHolder extends StatelessWidget {
  final GroupMember member;
  final bool isNotYou;

  const GroupMemberHolder({super.key, required this.member, required this.isNotYou});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 26.0, right: 26, top: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppIcons.holderAvatar,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomText.w400(
                isNotYou ? member.nickname! : LocalizedTexts.yourUser.tr(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.start,
                style: context.textTheme.bodyMedium?.copyWith(color: AppColors.greenDarkest),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
