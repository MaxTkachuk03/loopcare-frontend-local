class HtmlCustomStyles {
  HtmlCustomStyles._();

  static const List<String> _tagsWithPadding = ['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'span'];
  static const List<String> _imageTags = ['image', 'svg'];
  static const Map<String, Map<String, String>> _customStyles = {
    'padding': {'padding': '0 24px 0 24px'},
    'fullWidth': {'width': '100%'},
  };

  static bool shouldHavePadding(tag) => _tagsWithPadding.contains(tag);

  static bool isImageTag(tag) => _imageTags.contains(tag);

  static Map<String, String> customStyles(String propName) => _customStyles[propName] ?? {};
}
