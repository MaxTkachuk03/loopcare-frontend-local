String formatDuration(int durationInSeconds) {
  final seconds = durationInSeconds % 60;
  final minutes = (durationInSeconds / 60).floor();

  return "${minutes != 0 ? '${minutes}m' : ''} ${seconds != 0 ? '${seconds}s' : ''}";
}

String formatFullDuration(int durationInSeconds, {bool withSeconds = true}) {
  Duration d = Duration(seconds: durationInSeconds);

  var date = d.toString().split(":");

  var hours = int.parse(date[0]);
  var minutes = int.parse(date[1]);
  var seconds = int.parse(date[2].split(".")[0]);

  var strHours = hours != 0 ? '${hours}h' : '';
  var strMinutes = minutes != 0 ? ' ${minutes}m' : '';
  var strSeconds = withSeconds
      ? seconds != 0
          ? '${seconds}h'
          : ''
      : '';

  return "$strHours$strMinutes$strSeconds";
}
