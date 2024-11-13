import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/html_renderer/html_renderer.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/features/mind/domain/html_body_service/html_body_service.dart';

class HtmlLaunchContentRender extends StatelessWidget {
  const HtmlLaunchContentRender({
    super.key,
    required this.url,
    this.textStyle,
  }) : assert(url != '');

  /// html link. Example: https://abcd.efg/sample.html
  final String url;

  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: HtmlBodyService.getBodyFromHtml(url),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.only(top: 240),
            child: Center(child: Loader()),
          );
        } else {
          return HtmlRenderer(
            key: const ValueKey('HtmlLincContentRender'),
            content: snapshot.data!,
            textStyle: textStyle,
          );
        }
      },
    );
  }
}
