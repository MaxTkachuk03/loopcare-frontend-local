import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/buddy_question_wrap.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/widgets/buddy_continue_widget.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/widgets/buddy_progress_bar.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/widgets/live_together_chips.dart';

class BuddyLiveTogetherPage extends StatelessWidget {
  const BuddyLiveTogetherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BuddyQuestionWrap(
      child: CustomScaffold(
        withBg: false,
        color: AppColors.blueLightest,
        appBar: CustomAppBar.blue(
          title: LocalizedTexts.buddyPreferences.tr(),
          subtitle: LocalizedTexts.stepCounter.tr(args: ['1', '3']),
          leading: CustomFilledIconButton.leadingBlueLighter(),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(72),
            child: BuddyProgressBar.coral(backgroundColor: AppColors.blueRegular),
          ),
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 35),
                      CustomText.bitter600(
                        LocalizedTexts.buddyLiveTogetherTitle.tr(),
                        textAlign: TextAlign.start,
                        style: context.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 28),
                      const LiveTogetherChips(),
                    ],
                  ),
                  BlocBuilder<BuddyBloc, BuddyState>(builder: (BuildContext context, state) {
                    return BuddyContinueWidget(
                      enable: state.data.liveTogether != null,
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
