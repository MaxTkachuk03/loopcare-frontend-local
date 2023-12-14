import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class UnderlinedClickableText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const UnderlinedClickableText({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          shadows: const [Shadow(color: AppColors.black, offset: Offset(0, -2))],
          color: Colors.transparent,
          decoration: TextDecoration.underline,
          decorationColor: Colors.black,
          decorationThickness: 2,
        ),
      ),
    );
  }
}
