class  MindUtils {
  const MindUtils._();

  static String getDurationLine(int value) {
    final duration = Duration(seconds: value);

    final int minutes = duration.inMinutes;
    final int seconds = duration.inSeconds - (minutes * 60);

    final buffer = StringBuffer();
    if (minutes > 0) {
      buffer
        ..write(minutes.toString())
        ..write('m ');
    }

    if (seconds > 0) {
      buffer
        ..write(seconds.toString())
        ..write('s');
    }

    return buffer.toString();
  }
}
