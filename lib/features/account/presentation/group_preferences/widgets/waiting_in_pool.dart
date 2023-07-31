import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/group_preferences_form.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/outlined_box.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';

class WaitingInPool extends StatelessWidget {
  const WaitingInPool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocalizedTexts.weAreLookingForAMatch,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.blueDark),
              ).tr(),
              BlocBuilder<AuthenticationCubit, AuthenticationState>(builder: (BuildContext context, state) {
                return RichText(
                  text: TextSpan(
                    text: '${LocalizedTexts.weAreLookingForAGroupSince.translation}\n',
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: <TextSpan>[
                      TextSpan(
                          text: DateFormat.yMMMMEEEEd('en_EN')
                              .format(DateTime.parse(state.groupingStartedAt.toString())),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        const GroupPreferencesForm()
      ],
    );
  }
}
