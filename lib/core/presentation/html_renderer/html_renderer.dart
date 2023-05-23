import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';

class HtmlRenderer extends StatelessWidget {
  final String content;

  const HtmlRenderer({
    Key? key,
    required this.content,
  }) : super(key: key);

  Widget _onErrorBuilder(context, element, error) {
    return Text('$element error: $error');
  }

  Widget _onLoadingBuilder(context, element, error) {
    return const Loader();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: HtmlWidget(
          content,
          onErrorBuilder: _onErrorBuilder,
          onLoadingBuilder: _onLoadingBuilder,
          renderMode: RenderMode.listView,
        ),
      ),
    );
  }
}
