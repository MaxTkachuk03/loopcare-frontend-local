import 'package:ntp/ntp.dart';

class TimeService {
  TimeService();

  static Future<DateTime> get now async => await NTP.now(lookUpAddress: 'time.google.com');
}
