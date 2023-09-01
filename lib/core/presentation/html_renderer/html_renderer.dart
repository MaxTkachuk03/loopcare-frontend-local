import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:loopcare_frontend/core/domain/html_custom_styles.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:html/dom.dart' as dom;

class HtmlRenderer extends StatelessWidget {
  final String content;
  final TextStyle? textStyle;

  const HtmlRenderer({
    Key? key,
    required this.content,
    this.textStyle,
  }) : super(key: key);

  Widget _onErrorBuilder(context, element, error) {
    return Text('$element error: $error');
  }

  Widget _onLoadingBuilder(context, element, error) {
    return const Loader();
  }

  Map<String, String>? _stylesBuilder(dom.Element element) {
    if (HtmlCustomStyles.shouldHavePadding(element.localName)) {
      return HtmlCustomStyles.customStyles('padding');
    }

    if (HtmlCustomStyles.isImageTag(element.localName)) {
      return HtmlCustomStyles.customStyles('fullWidth');
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      content,
      onErrorBuilder: _onErrorBuilder,
      onLoadingBuilder: _onLoadingBuilder,
      renderMode: RenderMode.column,
      textStyle: textStyle ?? const TextStyle(height: 1.5),
      customStylesBuilder: _stylesBuilder,
    );
  }
}
