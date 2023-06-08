import 'package:loopcare_frontend/features/education/subtitle/domain/image_subtitle_model.dart';
import 'package:loopcare_frontend/features/education/subtitle/domain/image_subtitle_utils.dart';

class SubtitleController {
  final String fileContents;

  List<ImageSubtitle> get subtitles => _subtitles;

  final List<ImageSubtitle> _subtitles;

  bool get isEmpty => subtitles.isEmpty;

  bool get isNotEmpty => !isEmpty;

  SubtitleController.string(
    this.fileContents,
  ) : _subtitles = parseSubtitleString(fileContents);

  String textFromMilliseconds(int milliseconds, List<ImageSubtitle> subtitls) {
    final subtitle = subtitls.lastWhere(
      (data) => milliseconds >= (data.start) && milliseconds <= (data.end),
      orElse: () => ImageSubtitle.empty,
    );
    return subtitle.src;
  }
}
