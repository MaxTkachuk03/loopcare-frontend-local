import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/features/group_sessions/application/dto/group_session.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/group_sessions/presentation/widgets/timeslot_card.dart';

class NotBookedSessionsModalContent extends StatelessWidget {
  const NotBookedSessionsModalContent({Key? key}) : super(key: key);

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
          List<GroupSession> groupSessions = [...topic.groupSessions];
          groupSessions.sort((session1, session2) {
            return session1.startDate.compareTo(session2.startDate);
          });

          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocalizedTexts.pickADateAndTime,
                  style: Theme.of(context).textTheme.headlineSmall,
                ).tr(),
                const SizedBox(height: 16.0),
                Expanded(
                  child: ListView.separated(
                    itemCount: groupSessions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TimeslotCard(
                        duration: topic.duration,
                        groupSession: groupSessions[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 16.0);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _signUpFailureListener(BuildContext context, TopicsState state) {
    context.showErrorBar(
      content: Text(LocalizedTexts.somethingWentWrong.translation),
      position: FlashPosition.top,
    );
  }
}
