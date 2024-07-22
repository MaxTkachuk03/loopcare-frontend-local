bool isZeroAfterDecimal(double value) {
  return value.truncateToDouble() == value;
}