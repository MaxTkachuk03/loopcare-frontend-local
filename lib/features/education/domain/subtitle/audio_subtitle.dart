import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_subtitle.freezed.dart';
part 'audio_subtitle.g.dart';

@freezed
class AudioSubtitle with _$AudioSubtitle {
  const AudioSubtitle._();

  const factory AudioSubtitle({
    @Default(0) int start,
    @Default(0) int end,
    @Default('') String type,
    @Default('') String src,
  }) = _AudioSubtitle;

  factory AudioSubtitle.fromJson(Map<String, dynamic> json) => _$AudioSubtitleFromJson(json);
}
