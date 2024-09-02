import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/group_preferences_form.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/white_box.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/injection.dart';

final storage = getIt<SharedStorageService>();

class WaitingInPool extends StatefulWidget {
  const WaitingInPool({super.key});

  @override
  State<WaitingInPool> createState() => _WaitingInPoolState();
}

class _WaitingInPoolState extends State<WaitingInPool> {
  bool _shouldHideMessage = true;

  @override
  void initState() {
    super.initState();
    final userId = context.read<AuthenticationBloc>().state.data.id;

    _shouldHideMessage = storage.hasSawGroupPreferencesMessage(userId, UserGroupingState.waitingInPool);

    storage.setGroupPreferencesMessageVisibility(userId, UserGroupingState.waitingInPool);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!_shouldHideMessage)
          WhiteBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText.bitter600(
                  LocalizedTexts.weAreLookingForAMatch.tr(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: ThemeConstants.fontSize20),
                ),
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (BuildContext context, state) {
                    final groupingStartedAt = state.data.groupingStartedAt;

                    if (groupingStartedAt == null) return const SizedBox.shrink();

                    return RichText(
                      text: TextSpan(
                        text: '${LocalizedTexts.weAreLookingForAGroupSince.tr()}\n',
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: <TextSpan>[
                          TextSpan(
                              text: '${groupingStartedAt.fullDateWithYear}.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        const SizedBox(height: 10.0),
        const GroupPreferencesForm()
      ],
    );
  }
}
