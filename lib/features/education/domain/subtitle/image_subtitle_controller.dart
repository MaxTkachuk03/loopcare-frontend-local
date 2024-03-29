import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/education/domain/subtitle/audio_subtitle.dart';

class SubtitleController {
  SubtitleController();

  final ValueNotifier<List<AudioSubtitle>> _subTitles = ValueNotifier([]);
  final ValueNotifier<int> audioPosition = ValueNotifier(0);
  final ValueNotifier<AudioSubtitle?> activeSubtitleItem = ValueNotifier(null);
  final ValueNotifier<bool> isPlaying = ValueNotifier(false);

  bool get hasSubtitles => _subTitles.value.isNotEmpty;

  bool get hasActiveSubtitleItem => activeSubtitleItem.value != null;

  void setIsPlaying(bool value) => isPlaying.value = value;

  void setSubtitlesFile(String file) => _subTitles.value =
      (jsonDecode(file) as List<dynamic>).map((item) => AudioSubtitle.fromJson(item)).toList();

  void setAudioPosition(int position) => audioPosition.value = position;

  void setActiveSubtitleItem(int position) => activeSubtitleItem.value =
      _subTitles.value.lastWhereOrNull((s) => s.start <= position && position <= s.end);

  void dispose() {
    _subTitles.dispose();
    audioPosition.dispose();
    activeSubtitleItem.dispose();
    isPlaying.dispose();
  }
}
