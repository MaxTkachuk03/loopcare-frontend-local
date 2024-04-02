extension StringExtension on String {
  String capitalize() {
    if (this == '') return '';
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String capitalizeEachWordFirstLetter() {
    if (this == '') return '';
    return split(' ').map((w) => w.capitalizeOnlyFirstLetter()).join(' ');
  }

  String capitalizeOnlyFirstLetter() {
    if (this == '') return '';
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String get replaceCommaWithDot {
    return replaceAll(',', '.');
  }

  String get deleteDotAtTheEnd {
    if (endsWith('.')) return replaceAll('.', '');
    return this;
  }
}
