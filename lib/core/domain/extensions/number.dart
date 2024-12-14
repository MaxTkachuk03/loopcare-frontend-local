extension NumberExtension<T extends num> on T {
  bool isInRange(num ini, num fim) => this >= ini && this <= fim;

  bool isNotInRange(num ini, num fim) => this < ini || this > fim;
}
