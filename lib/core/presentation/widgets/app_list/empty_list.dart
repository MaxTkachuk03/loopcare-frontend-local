import 'package:flutter/widgets.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class EmptyList extends StatelessWidget {
  final String holderText;

  const EmptyList({
    super.key,
    required this.holderText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 56.0, horizontal: 24.0),
      child: Text(
        holderText,
        style: context.textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
