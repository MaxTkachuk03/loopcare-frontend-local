import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/utils/string_extensions.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/account_container.dart';
import 'package:loopcare_frontend/features/account/presentation/account_page/widgets/section_item.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_bloc.dart';
import 'package:provider/provider.dart';

class ProfileNoBuddyState extends StatefulWidget {
  const ProfileNoBuddyState({super.key});

  @override
  State<ProfileNoBuddyState> createState() => _ProfileNoBuddyStateState();
}

class _ProfileNoBuddyStateState extends State<ProfileNoBuddyState> {
  @override
  Widget build(BuildContext context) {
    return AccountContainer(
      child: SectionItem(
          title: LocalizedTexts.buddyNoPreferencesState.tr(),
          subTitle: LocalizedTexts.no.tr().capitalize(),
          onPressHandler: () {
            context.read<BuddyBloc>().add(const BuddyEvent.init());
            context.router.pushNamed(AppRoutes.buddyLiveTogether);
          }),
    );
  }
}
