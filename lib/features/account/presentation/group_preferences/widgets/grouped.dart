import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/group_preferences_form.dart';
import 'package:loopcare_frontend/features/account/presentation/group_preferences/widgets/white_box.dart';
import 'package:loopcare_frontend/injection.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

final storage = getIt<SharedStorageService>();

class Grouped extends StatefulWidget {
  const Grouped({super.key});

  @override
  State<Grouped> createState() => _GroupedState();
}

class _GroupedState extends State<Grouped> {
  bool _shouldHideMessage = true;

  @override
  void initState() {
    super.initState();
    final userId = getIt<SharedStorageService>().account!.id;

    _shouldHideMessage = storage.hasSawGroupPreferencesMessage(userId, UserGroupingState.grouped);

    storage.setGroupPreferencesMessageVisibility(userId, UserGroupingState.grouped);
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
                  LocalizedTexts.goodNews.tr(),
                  style: context.textTheme.bodyLarge?.copyWith(fontSize: ThemeConstants.fontSize20),
                ),
                CustomText(LocalizedTexts.youHaveBeenAddedToGroup.tr()),
              ],
            ),
          ),
        const SizedBox(height: 10.0),
        const GroupPreferencesForm()
      ],
    );
  }
}
