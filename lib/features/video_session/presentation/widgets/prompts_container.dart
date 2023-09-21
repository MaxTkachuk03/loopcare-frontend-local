import 'package:just_audio/just_audio.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/sounds/app_sounds.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

class PromptsContainer extends StatefulWidget {
  final String text;

  const PromptsContainer({super.key, required this.text});

  static const _animationDuration = Duration(milliseconds: 300);

  @override
  State<PromptsContainer> createState() => _PromptsContainerState();
}

class _PromptsContainerState extends State<PromptsContainer> {
  final AudioPlayer player = AudioPlayer();

  String _text = '';

  @override
  void initState() {
    super.initState();

    player.setAsset(AppSounds.plop);
    player.setVolume(1.0);

    _text = widget.text;
  }

  @override
  void didUpdateWidget(covariant PromptsContainer oldWidget) {
    if (oldWidget.text == widget.text) return;
    _text = widget.text;

    player.play();
    player.seek(const Duration(milliseconds: 0));

    super.didUpdateWidget(oldWidget);
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
          child: AnimatedSwitcher(
            duration: PromptsContainer._animationDuration,
            child: AutoSizeText(
              _text,
              key: ValueKey<String>(widget.text),
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: AppColors.darkGreen),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();

    super.dispose();
  }
}
