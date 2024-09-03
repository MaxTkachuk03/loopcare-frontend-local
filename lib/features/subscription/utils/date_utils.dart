import 'package:intl/intl.dart';

class SubscriptionDateUtils {
  static bool isPassDate(String? timeStamp) {
    if (timeStamp == null) {
      return true;
    }

    final date = DateFormat('yyyy-MM-ddTHH:mm:sssZ').parseUtc(timeStamp).toLocal();
    return date.isBefore(DateTime.now());
  }

  static String getTransactionDate(String? timeStamp) {
    if (timeStamp == null) {
      return '';
    }
    final date = DateFormat('yyyy-MM-ddTHH:mm:sssZ').parseUtc(timeStamp).toLocal();
    String transactionDate = DateFormat('dd MMM yyyy').format(date);
    return transactionDate;
  }

  static String getTransactionFromMillisecondsSinceEpoch(String transactionDate) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(
      int.parse(transactionDate),
    );
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }
}
