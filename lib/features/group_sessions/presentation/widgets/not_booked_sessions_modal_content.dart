import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/show_app_snackbar.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/group_sessions/presentation/widgets/timeslot_card.dart';

class NotBookedSessionsModalContent extends StatelessWidget {
  const NotBookedSessionsModalContent({super.key});

  void _signUpFailureListener(BuildContext context, TopicsState state) =>
      context.showError(content: CustomText.w400(LocalizedTexts.errorSomethingWentWrong.tr()));

  @override
  Widget build(BuildContext context) {
    return BlocListener<TopicsBloc, TopicsState>(
      listenWhen: (prev, cur) => prev is TopicsStateLoading && cur is TopicsStateError,
      listener: _signUpFailureListener,
      child: BlocBuilder<TopicsBloc, TopicsState>(
        builder: (context, state) {
          if (state.data.isLoading) return const Expanded(child: Loader());

          final topic = state.data.weekTopic;

          if (topic == null) return const SizedBox.shrink();

          final groupSessions = state.data.weeklyTopicSortedSessions;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.w600(
                LocalizedTexts.pickADateAndTime.tr(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16.0),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: groupSessions.length,
                itemBuilder: (BuildContext context, int index) =>
                    TimeslotCard(duration: topic.duration, groupSession: groupSessions[index]),
                separatorBuilder: (_, __) => const SizedBox(height: 16.0),
              ),
            ],
          );
        },
      ),
    );
  }
}
