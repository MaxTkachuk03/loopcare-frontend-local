import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';

class ProfileNoBuddyState extends StatelessWidget {
  const ProfileNoBuddyState({super.key});

  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      child: SectionItem(
        title: LocalizedTexts.buddyNoPreferencesState.tr(),
        subTitle: LocalizedTexts.no.tr().capitalize(),
        onPressHandler: () => {},
      ),
    );
  }
}
