import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';

class UnlockBloc extends StatelessWidget {
  const UnlockBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Image(image: AppIcons.unlock),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocalizedTexts.groupSessionsUnlocked,
                  style: Theme.of(context).textTheme.titleLarge,
                ).tr(),
                const SizedBox(
                  height: 4.0,
                ),
                BlocBuilder<AuthenticationCubit, AuthenticationState>(
                  builder: (context, state) {
                    if (state.groupingState == UserGroupingState.waitingInPool) {
                      return const Text(LocalizedTexts.waitingForGroupCompletedLesson).tr();
                    }

                    return const Text(LocalizedTexts.notJoinedToGroupCompletedLesson).tr();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
