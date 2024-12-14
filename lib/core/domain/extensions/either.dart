import 'package:dartz/dartz.dart';

extension ExtensionEither<L, R> on Either<L, R> {
  L? get onlyLeft => fold((l) => l, (r) => null);

  R? get onlyRight => fold((l) => null, (r) => r);
}
