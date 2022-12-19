import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/intro/presentation/widgets/intro_bottom.dart';
import 'package:loopcare_frontend/features/intro/presentation/widgets/intro_top.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: MainContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    IntroTop(),
                    SizedBox(
                      height: 24.0,
                    ),
                    IntroBottom(),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
