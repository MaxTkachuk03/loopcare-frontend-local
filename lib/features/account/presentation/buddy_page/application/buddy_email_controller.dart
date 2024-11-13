import 'package:flutter/material.dart';

class BuddyEmailController {
  final formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> enableNotifier = ValueNotifier(false);
  String? emailErrorText;

  final TextEditingController emailController = TextEditingController();

  void dispose() => emailController.dispose();
}
