import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/application/localization/localizer_extenstion.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';

class InformationDialog extends StatelessWidget {
  final String title;
  final String content;

  const InformationDialog({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText.w600(title),
      content: CustomText.w400(content),
      actions: <Widget>[
        TextButton(
          onPressed: context.router.maybePop,
          child: CustomText.w600(LocalizedTexts.ok.tr().toUpperCase()),
        ),
      ],
    );
  }
}
