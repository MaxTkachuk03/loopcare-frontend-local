import 'package:ntp/ntp.dart';

class TimeService {
  TimeService();

  static Future<DateTime> get now async => await NTP.now(lookUpAddress: 'time.google.com');

  static Future<Duration> passedFromNtp(DateTime startTime) async {
    final ntp = await now;

    return ntp.difference(startTime);
  }

  static Future<Duration> beforeNtp(DateTime startTime) async {
    final ntp = await now;

    return startTime.difference(ntp);
  }
}
