import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';
import 'package:loopcare_frontend/features/video_session/application/session_call_bloc.dart';

class PromptsContainer extends StatelessWidget {
  const PromptsContainer({super.key});

  static const _animationDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCallBloc, SessionCallState>(
      builder: (context, state) {
        final textEvents = context.read<TopicsBloc>().state.data.textEvents;
        final text = textEvents.lastWhereOrNull((e) => state.data.sessionTime >= e.timestamp)?.text ?? '';

        return Container(
          height: 100,
          color: AppColors.white,
          width: double.infinity,
          padding: const EdgeInsets.all(24.0),
          child: ScrollableContainer(
            child: Center(
              child: AnimatedSwitcher(
                duration: _animationDuration,
                child: AutoSizeText(
                  text,
                  key: ValueKey<String>(text),
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w600, color: AppColors.darkGreen),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
