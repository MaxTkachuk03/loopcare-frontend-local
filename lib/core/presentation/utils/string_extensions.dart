extension StringExtension on String {
  String capitalize() {
    if (this == '') return '';
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String capitalizeOnlyFirstLetter() {
    if (this == '') return '';
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
