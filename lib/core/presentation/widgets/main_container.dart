import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  final Widget child;

  const MainContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: child,
    );
  }
}
