import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/onboarding/onboarding_physical/utils/date_time_utils.dart';
import 'package:loopcare_frontend/features/video_session/application/session_call_bloc.dart';

class SessionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String sessionName;
  final void Function() onEndSessionHandler;

  const SessionAppBar({super.key, required this.sessionName, required this.onEndSessionHandler});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.blueAppBar,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            sessionName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                ),
          ),
          BlocBuilder<SessionCallBloc, SessionCallState>(
            builder: (context, state) {
              return Text(
                '${LocalizedTexts.duration.tr()} ${formatSecondsToDurationString(state.data.sessionTime)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
              );
            },
          ),
        ],
      ),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          iconSize: 45.0,
          onPressed: onEndSessionHandler,
          icon: AppIcons.greenPhone,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
