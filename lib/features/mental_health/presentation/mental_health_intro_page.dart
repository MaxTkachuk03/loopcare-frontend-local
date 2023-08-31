import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/small_filled_button.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/presentation/mental_health_wrap.dart';

class MentalHealthIntroPage extends StatefulWidget {
  const MentalHealthIntroPage({Key? key}) : super(key: key);

  @override
  State<MentalHealthIntroPage> createState() => _MentalHealthIntroPageState();
}

class _MentalHealthIntroPageState extends State<MentalHealthIntroPage> {
  Timer? _timer;

  @override
  void initState() {
    final bloc = context.read<MentalHealthBloc>();

    bloc.add(const MentalHealthEvent.getMentalHealthTests());

    if (bloc.state.data.startTestTime != null) {
      _startTimer();
    }

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MentalHealthWrap(
      withoutPagination: true,
      child: MultiBlocListener(
        listeners: [
          BlocListener<MentalHealthBloc, MentalHealthState>(
            listenWhen: (prev, cur) => prev.data.startTestTime == null && cur.data.startTestTime != null,
            listener: _listenerTestWasStarted,
          ),
          BlocListener<MentalHealthBloc, MentalHealthState>(
            listenWhen: (prev, cur) => !prev.data.isCompleted && cur.data.isCompleted,
            listener: _listenerTestWasCompleted,
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24.0,
            ),
            Text(
              LocalizedTexts.yourMentalHealth,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontFamily: ThemeConstants.bitterFontFamily,
                    color: AppColors.blueDark,
                  ),
            ).tr(),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              LocalizedTexts.mentalHealthIntroTextOne,
              style: Theme.of(context).textTheme.bodyLarge,
            ).tr(),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              LocalizedTexts.mentalHealthIntroTextTwo,
              style: Theme.of(context).textTheme.bodyLarge,
            ).tr(),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              LocalizedTexts.mentalHealthIntroTextThree,
              style: Theme.of(context).textTheme.bodyLarge,
            ).tr(),
            const SizedBox(
              height: 20.0,
            ),
            SmallFilledButton(
              backgroundColor: AppColors.greyLight,
              text: LocalizedTexts.moreInfo.tr(),
              onPressed: () => _onMoreInfoPressed(context),
            ),
            const SizedBox(
              height: 45.0,
            ),
            ElevatedButton(
              onPressed: () => _onNextPressed(context),
              child: const Text(LocalizedTexts.next).tr(),
            ),
            const SizedBox(
              height: 25.0,
            ),
          ],
        ),
      ),
    );
  }

  void _startTimer() {
    final bloc = context.read<MentalHealthBloc>();
    final startTestTime = bloc.state.data.startTestTime;

    if (startTestTime == null) return;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final timeWasExceededCheck = DateTime.now().isAfter(startTestTime.add(const Duration(hours: 1)));

        if (timeWasExceededCheck) {

          timer.cancel();

          ModalBottomSheet.timeWasExceeded(
            context: context,
            onStartAgain: () {
              bloc.add(const MentalHealthEvent.startTestFromBeginning());
              context.router.popUntilRouteWithName(MentalHealthIntroRoute.name);
            },
          );
        }
      },
    );
  }

  _onNextPressed(BuildContext context) {
    final bloc = context.read<MentalHealthBloc>();

    if (bloc.state.data.startTestTime == null) {
      bloc.add(MentalHealthEvent.setStartTime(DateTime.now()));
    }

    context.router.pushNamed(AppRoutes.mentalHealthQuestion);
  }

  void _listenerTestWasStarted(BuildContext context, MentalHealthState state) {
    _startTimer();
  }

  void _listenerTestWasCompleted(BuildContext context, MentalHealthState state) {
    _timer?.cancel();
  }

  _onMoreInfoPressed(BuildContext context) {
    ModalBottomSheet.mentalHealthMoreInfo(context: context);
  }
}
