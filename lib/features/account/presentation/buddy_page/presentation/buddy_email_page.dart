import 'package:auto_route/auto_route.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_bloc.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_email_controller.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/widgets/buddy_email_widget.dart';
import 'package:loopcare_frontend/features/onboarding/presentation/widgets/progress_bar.dart';

@RoutePage()
class BuddyEmailPage extends StatefulWidget {
  const BuddyEmailPage({super.key});

  @override
  State<BuddyEmailPage> createState() => _BuddyEmailPageState();
}

class _BuddyEmailPageState extends State<BuddyEmailPage> {
  final BuddyEmailController controller = BuddyEmailController();

  void _onNextHandler(BuildContext context) {
    context.read<BuddyBloc>()
      ..add(BuddyEvent.email(email: controller.emailController.text))
      ..add(const BuddyEvent.inviteBuddy());
  }

  void _onBuddyChangeListener(BuildContext context, BuddyState state) {
    if (state is BuddyStateError) {
      context.showError(content: CustomText(state.data.errorMessage.tr()));
      return;
    }

    context.router.pushNamed(AppRoutes.buddyCompleted);
  }

  bool _onListenWhenHandler(prev, cur) =>
      prev is BuddyStateLoading && cur is BuddyStateInvited ||
      prev is BuddyStateLoading && cur is BuddyStateError;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BuddyBloc, BuddyState>(
      listener: _onBuddyChangeListener,
      listenWhen: _onListenWhenHandler,
      child: CustomScaffold(
        withBg: false,
        color: AppColors.blueLightest,
        appBar: CustomAppBar.blue(
          title: LocalizedTexts.buddyPreferences.tr(),
          subtitle: LocalizedTexts.stepCounter.tr({'currentStep': 3, 'totalSteps': 3}),
          leading: CustomFilledIconButton.leadingBlueLighter(),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(72),
            child: ProgressBar(
              backgroundColor: AppColors.blueRegular,
              progressFillColor: AppColors.white,
              progressEmptyColor: AppColors.blueLighter,
              segments: 3,
              value: 3,
              progress: 3,
            ),
          ),
        ),
        body: CustomSafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 35),
                      CustomText.bitter500(
                        LocalizedTexts.buddyEmailTitle.tr(),
                        textAlign: TextAlign.start,
                        style: context.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 28),
                      CustomText.w400(
                        LocalizedTexts.buddyEmailLabel.tr(),
                        textAlign: TextAlign.start,
                        style: context.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 28),
                      BuddyEmailWidget(controller: controller),
                      const SizedBox(height: 28),
                    ],
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: controller.enableNotifier,
                    builder: (context, isEnable, _) => Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: CustomElevatedButton.blueFullWidth(
                        onPressed: isEnable ? () => _onNextHandler(context) : null,
                        label: LocalizedTexts.next.tr(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
