import 'package:flutter/material.dart';

class FavouriteBtn extends StatelessWidget {
  final void Function() onPress;
  final bool isActive;

  const FavouriteBtn({
    Key? key,
    required this.onPress,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 32,
      icon: Icon(
        isActive ? Icons.star : Icons.star_border,
        color: Colors.white,
      ),
      onPressed: onPress,
    );
  }
}
