import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_utils.dart';
import 'package:loopcare_frontend/core/presentation/widgets/custom_rounded_container.dart';
import 'package:loopcare_frontend/features/video_session/application/session_call_bloc.dart';

class SessionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String sessionName;
  final void Function() onEndSessionHandler;

  const SessionAppBar({
    super.key,
    required this.sessionName,
    required this.onEndSessionHandler,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.orangeRegular,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText.w600(
              sessionName,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge,
            ),
            BlocBuilder<SessionCallBloc, SessionCallState>(
              builder: (context, state) {
                return CustomRoundedContainer(
                  borderRadius: 5.0,
                  bgColor: AppColors.orangeLighter,
                  child: CustomText.w600(
                    '${LocalizedTexts.duration.tr()} ${formatSecondsToTimeString(state.data.sessionTime)}',
                    style: context.textTheme.bodySmall,
                  ),
                );
              },
            ),
            // SizedBox(height: 8.0)
          ],
        ),
      ),
      automaticallyImplyLeading: false,
      actions: [
        CustomIconButton(
          icon: AppIcons.customRedPhone,
          onPressed: onEndSessionHandler,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
