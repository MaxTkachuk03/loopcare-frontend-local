import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';

part 'account.g.dart';

@freezed
abstract class Account implements _$Account {
  const Account._();

  const factory Account({
    required int id,
    required String name,
    required String email,
    required String? country,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}
