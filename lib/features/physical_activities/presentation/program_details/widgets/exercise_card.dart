import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class ExerciseCard extends StatelessWidget {
  final int index;

  const ExerciseCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 156,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRc2nxuVNfAMIv3rHTxOndwmbTfPouNpzuE7qG5geSZgQ&s'),
              fit: BoxFit.cover,
            )
          ),
        ),
        Expanded(
          child: Container(
            color: AppColors.white,
            padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0, bottom: 32.0),
            child: Text('$index. Test'),
          ),
        )
      ],
    );
  }
}
