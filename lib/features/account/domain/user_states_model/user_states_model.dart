import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_status.dart';

part 'user_states_model.g.dart';
part 'user_states_model.freezed.dart';

@freezed
class UserStatesModel with _$UserStatesModel {
  const UserStatesModel._();

  const factory UserStatesModel({
    required int id,
    @Default(false) bool showBuddyBadge,
    BuddyStatus? buddyStatus,
  }) = _UserStatesModel;

  factory UserStatesModel.fromJson(Map<String, dynamic> json) => _$UserStatesModelFromJson(json);
}
