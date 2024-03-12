import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/group_preferences_form.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/white_box.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/injection.dart';

final storage = getIt<SharedStorageService>();

class CanNotFindGroup extends StatefulWidget {
  const CanNotFindGroup({super.key});

  @override
  State<CanNotFindGroup> createState() => _CanNotFindGroupState();
}

class _CanNotFindGroupState extends State<CanNotFindGroup> {
  bool _shouldHideMessage = true;

  @override
  void initState() {
    super.initState();
    final userId = context.read<AuthenticationCubit>().state.id;

    _shouldHideMessage =
        storage.hasSawGroupPreferencesMessage(userId, UserGroupingState.loopedOnGenderPreferences);

    storage.setGroupPreferencesMessageVisibility(userId, UserGroupingState.loopedOnGenderPreferences);
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
                  LocalizedTexts.update.tr(),
                  style: context.textTheme.bodyLarge?.copyWith(fontSize: ThemeConstants.fontSize20),
                ),
                BlocBuilder<AuthenticationCubit, AuthenticationState>(
                  builder: (BuildContext context, state) {
                    final groupingStartedAt = state.groupingStartedAt;

                    if (groupingStartedAt == null) return const SizedBox.shrink();

                    return CustomText.w400(
                      LocalizedTexts.weHaveNotYetFound.translation.tr(namedArgs: {
                        'dateTime':
                            '${groupingStartedAt.fullDateWithYear} ${LocalizedTexts.at.translation} ${groupingStartedAt.timeHoursMinutes}.'
                      }),
                      style: context.textTheme.bodyMedium,
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
