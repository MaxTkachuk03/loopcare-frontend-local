import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/mood/infrastructure/mood_emotion.dart';

class EmotionsList extends StatelessWidget {
  final List<MoodEmotion> data;

  const EmotionsList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
      itemBuilder: (BuildContext context, int i) {
        final el = data[i];

        return Row(children: [el.icon, const SizedBox(width: 7.0), Text(el.value)]);
      },
    );
  }
}
