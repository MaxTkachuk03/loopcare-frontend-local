class RegExpUtils {
  static const upperCaseLetters = r"(?<=[a-z])(?=[A-Z])";

  static const withDecimals = r"[0-9]+[,.]{0,1}[0-9]*";

  static const onlyDigits = r"[0-9]";

  static const digitsReg = r".*[0-9].*";

  static const letterReg = r".*[A-Za-z].*";

  static const specialCharactersReg = r".*[/$&+,:;=?@#|'<>.^*()%!%~-].*";

  RegExpUtils._();
}
