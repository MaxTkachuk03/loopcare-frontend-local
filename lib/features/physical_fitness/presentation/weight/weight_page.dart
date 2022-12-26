import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/underlined_clickable_text.dart';
import 'package:loopcare_frontend/features/physical_fitness/application/physical_fitness_bloc.dart';
import 'package:loopcare_frontend/features/physical_fitness/presentation/weight/widgets/weight_tabs.dart';

class WeightPage extends StatelessWidget {
  const WeightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocalizedTexts.bodyAndMind.tr()),
        ),
        body: SafeArea(
          child: ScrollableContainer(
            child: MainContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocalizedTexts.yourWeight.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const WeightTabs(),
                  const SizedBox(
                    height: 16.0,
                  ),
                  UnderlinedClickableText(
                    text: LocalizedTexts.needHelpWithThis.tr(),
                    onTap: _onHelpTap,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () => _onNextPressed(context),
                    style: Theme.of(context)
                        .elevatedButtonTheme
                        .style
                        ?.copyWith(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.orangeDark),
                        ),
                    child: Text(LocalizedTexts.next.tr()),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onHelpTap() {}

  void _onNextPressed(BuildContext context) {
    final bloc = context.read<PhysicalFitnessBloc>();
    final currentRoute =
        bloc.state.currentQuestion.getNextQuestion().currentRoute;

    bloc.add(const PhysicalFitnessEvent.nextQuestion());

    if (currentRoute != null) {
      context.router.pushNamed(currentRoute);
    }
  }

  _onWillPop(BuildContext context) {
    context.read<PhysicalFitnessBloc>().add(
          const PhysicalFitnessEvent.previousQuestion(),
        );

    return Future.value(true);
  }
}
