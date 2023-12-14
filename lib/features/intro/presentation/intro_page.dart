import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/intro/presentation/widgets/intro_bottom.dart';
import 'package:loopcare_frontend/features/intro/presentation/widgets/intro_top.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IntroTop(),
                IntroBottom(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
