part of "../split_intl.dart";

extension StringExtension on String {
  String snakeToCamel() => snakeToPascal().decapitalize();

  String snakeToPascal() => split("_").map((e) => e.capitalize()).join("");
}
