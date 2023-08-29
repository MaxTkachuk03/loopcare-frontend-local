import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/group_sessions/application/topics_bloc.dart';

class PromptsContainer extends StatefulWidget {
  final int sessionTimer;

  const PromptsContainer({super.key, required this.sessionTimer});

  @override
  State<PromptsContainer> createState() => _PromptsContainerState();
}

class _PromptsContainerState extends State<PromptsContainer> {
  String get currentPrompt {
    final textEvents = context.read<TopicsBloc>().state.data.textEvents;

    return textEvents.lastWhere((e) => widget.sessionTimer >= e.timestamp).text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: AppColors.white,
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      child: ScrollableContainer(
        child: Center(
          child: AutoSizeText(
            currentPrompt,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: AppColors.darkGreen),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
