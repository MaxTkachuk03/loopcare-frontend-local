String formatDuration(int durationInSeconds) {
  final seconds = durationInSeconds % 60;
  final minutes = (durationInSeconds / 60).floor();

  return "${minutes != 0 ? '${minutes}m' : ''} ${seconds != 0 ? '${seconds}s' : ''}";
}
