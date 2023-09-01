import 'package:easy_localization/easy_localization.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/bullet_list_item.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/group_sessions/presentation/widgets/booked_session_card.dart';

class BookedSessionModalContent extends StatelessWidget {
  const BookedSessionModalContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<TopicsBloc, TopicsState>(
      listenWhen: (prev, cur) => prev is TopicsStateLoading && cur is TopicsStateError,
      listener: _signOutFailureListener,
      child: BlocBuilder<TopicsBloc, TopicsState>(
        builder: (context, state) {
          if (state.data.isLoading) return const Expanded(child: Loader());

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocalizedTexts.bookedForYou,
                style: Theme.of(context).textTheme.headlineSmall,
              ).tr(),
              const SizedBox(height: 16.0),
              BookedSessionCard(
                duration: state.data.topics[DateTime.now().weekNumber]?.duration ?? 0,
                groupSession: state.data.signedGroupSession!,
              ),
              const SizedBox(height: 16.0),
              BulletListItem(
                bulletSize: 14.0,
                centered: false,
                text: Text(LocalizedTexts.sessionWarning_1.tr()),
              ),
              BulletListItem(
                bulletSize: 14.0,
                centered: false,
                text: Text(LocalizedTexts.sessionWarning_2.tr()),
              ),
            ],
          );
        },
      ),
    );
  }

  void _signOutFailureListener(BuildContext context, TopicsState state) {
    context.showErrorBar(
      content: Text(LocalizedTexts.somethingWentWrong.translation),
      position: FlashPosition.top,
    );
  }
}
