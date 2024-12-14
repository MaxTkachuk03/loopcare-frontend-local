import 'dart:async';

extension FunctionExtension on Function {
  void Function(dynamic arg) withDebounce(Duration duration) {
    Timer? debounce;

    return (arg) {
      if (debounce?.isActive ?? false) debounce?.cancel();

      debounce = Timer(duration, () => this(arg));
    };
  }
}
