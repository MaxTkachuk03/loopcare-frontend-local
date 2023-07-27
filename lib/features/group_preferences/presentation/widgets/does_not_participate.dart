import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/group_preferences/presentation/widgets/white_box.dart';

class DoesNotParticipate extends StatelessWidget {
  const DoesNotParticipate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WhiteBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: const Text(LocalizedTexts.wouldYouLikeToJoinSupportGroup).tr()),
              const ImageIcon(
                AppIcons.arrow,
                color: AppColors.greyLabel,
              )
            ],
          ),
          const SizedBox(
            height: 4.0,
          ),
          Text(
            LocalizedTexts.no.capitalize(),
            style: Theme.of(context).textTheme.headlineSmall,
          ).tr()
        ],
      ),
    );
  }
}
