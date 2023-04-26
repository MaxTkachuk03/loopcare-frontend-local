import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: ScrollableContainer(
          child: MainContainer(
            child: Center(
              child: Text('User account'),
            ),
          ),
        ),
      ),
    );
  }
}
