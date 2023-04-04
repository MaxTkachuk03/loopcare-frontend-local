import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';

class DisabledProteinDegreeBlock extends StatelessWidget {
  const DisabledProteinDegreeBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocalizedTexts.proteinDegree.translation
                    .toUpperCase(),
                style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12.0,
                ),
              ),
              Text(
                '-',
                style:
                Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
