import 'package:flutter/cupertino.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';

enum MoodEmotion {
  sad(1, 'Sad'),
  worried(2, 'Worried'),
  embarrassed(3, 'Embarrassed'),
  bored(4, 'Bored'),
  proud(5, 'Proud'),
  happy(6, 'Happy'),
  energised(7, 'Energized'),
  sick(8, 'Sick'),
  angry(9, 'Angry'),
  ashamed(10, 'Ashamed'),
  nervous(11, 'Nervous'),
  exhausted(12, 'Exhausted'),
  content(13, 'Content'),
  overwhelmed(14, 'Overwhelmed'),
  hungry(15, 'Hungry'),
  lonely(16, 'Lonely');

  const MoodEmotion(this.number, this.value);

  static MoodEmotion getValueByString(String val) => values.firstWhere((e) => e.value == val);

  final int number;
  final String value;

  Widget get icon {
    switch (value) {
      case 'Sad':
        return AppIcons.emojiSad;
      case 'Worried':
        return AppIcons.emojiWorried;
      case 'Embarrassed':
        return AppIcons.emojiEmbarrassed;
      case 'Bored':
        return AppIcons.emojiBored;
      case 'Proud':
        return AppIcons.emojiProud;
      case 'Happy':
        return AppIcons.emojiHappy;
      case 'Energised':
        return AppIcons.emojiEnergized;
      case 'Sick':
        return AppIcons.emojiSick;
      case 'Angry':
        return AppIcons.emojiAngry;
      case 'Ashamed':
        return AppIcons.emojiAshamed;
      case 'Nervous':
        return AppIcons.emojiNervous;
      case 'Exhausted':
        return AppIcons.emojiExhausted;
      case 'Content':
        return AppIcons.emojiContent;
      case 'Overwhelmed':
        return AppIcons.emojiOverwhelmed;
      case 'Hungry':
        return AppIcons.emojiHungry;
      case 'Lonely':
        return AppIcons.emojiLonely;
      default:
        return AppIcons.emojiSad;
    }
  }
}
