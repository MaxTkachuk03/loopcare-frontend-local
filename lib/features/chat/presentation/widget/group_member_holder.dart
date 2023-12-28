import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/chat/domain/group_member.dart';

class GroupMemberHolder extends StatelessWidget {
  final GroupMember member;

  const GroupMemberHolder({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 13.0),
          child: AppIcons.holderAvatar,
        ),
        Expanded(
          child: CustomText.w400(
            member.nickname!,
            textAlign: TextAlign.start,
            style: context.textTheme.bodyMedium?.copyWith(color: AppColors.darkGreen),
          ),
        ),
      ],
    );
  }
}
