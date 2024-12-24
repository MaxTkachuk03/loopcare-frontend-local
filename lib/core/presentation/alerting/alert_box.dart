import 'package:flutter/material.dart';

class AlertBox {
  static void goalDeleteAlertBox({
    required BuildContext context,
    required Widget content,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: content,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
