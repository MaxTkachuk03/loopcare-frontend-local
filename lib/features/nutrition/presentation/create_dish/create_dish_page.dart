import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/blue_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';

class CreateDishPage extends StatelessWidget {
  const CreateDishPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BlueAppBar(
        isCustomLeading: true,
        title: 'Add to my dishes as',
      ),
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Text('Create dish page'),
          ),
        ),
      ),
    );
  }
}
