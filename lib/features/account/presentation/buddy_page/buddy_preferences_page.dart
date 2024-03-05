import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/widgets/profile_buddy_no_state.dart';
import 'package:loopcare_frontend/features/subscription/application/subscription_bloc.dart';

class BuddyPreferencesPage extends StatelessWidget {
  const BuddyPreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubscriptionBloc, SubscriptionState>(
      listener: (context, state) => state.maybeMap(
        error: (state) => _errorListener,
        orElse: () => null,
      ),
      builder: (context, state) {
        return CustomScaffold.blue(
          needBottomFacture: true,
          appBar: CustomAppBar.blue(
            leading: CustomFilledIconButton.leadingBlueLighter(),
            title: LocalizedTexts.buddyPreferences.tr(),
          ),
          body: const SafeArea(
            child: ScrollableContainer(
              child: MainContainer(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    ProfileNoBuddyState(),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _errorListener(BuildContext context, SubscriptionState state) {
    final errorMessage = state.data.errorMessage ?? LocalizedTexts.somethingWentWrong.tr();
    context.showErrorBar(
      content: Text(errorMessage),
      position: FlashPosition.top,
    );
    context.router.pop();
  }
}
