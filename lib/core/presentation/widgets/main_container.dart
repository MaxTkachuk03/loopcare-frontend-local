import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  final Widget child;

  const MainContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: child,
    );
  }
}
