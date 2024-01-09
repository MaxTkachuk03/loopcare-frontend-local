import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';

class MentalHealthWrap extends StatelessWidget {
  final Widget child;
  final bool? withoutPagination;

  const MentalHealthWrap({super.key, required this.child, this.withoutPagination});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: child,
    );

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                LocalizedTexts.bodyAndMind,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ).tr(),
              BlocBuilder<MentalHealthBloc, MentalHealthState>(
                builder: (context, state) {
                  final curQuestionId = state.data.currentQuestion?.id;

                  if (curQuestionId == null) return const SizedBox.shrink();

                  final curIndex = state.data.questionsListId.indexOf(curQuestionId) + 1;
                  final paginationText = withoutPagination ?? false
                      ? ''
                      : ': $curIndex ${LocalizedTexts.of.translation} ${state.data.totalQuestionsLength}';

                  return Text(
                    '${LocalizedTexts.mentalHealth.translation}$paginationText',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  );
                },
              ),
            ],
          ),
        ),
        body: child,
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) {
    context.read<MentalHealthBloc>().add(const MentalHealthEvent.prevPage());

    return Future.value(true);
  }
}
