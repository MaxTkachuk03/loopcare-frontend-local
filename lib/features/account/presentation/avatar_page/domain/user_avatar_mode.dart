import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_avatar_mode.freezed.dart';

@freezed
class UserAvatarMode with _$UserAvatarMode {
  const factory UserAvatarMode.local() = UserAvatarModeLocal;

  const factory UserAvatarMode.network() = UserAvatarModeNetwork;
}
