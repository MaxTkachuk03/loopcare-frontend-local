import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_status.dart';

part 'user_states_model.g.dart';

@immutable
@JsonSerializable()
class UserStatesModel {
  final int id;
  final BuddyStatus? buddyStatus;

  const UserStatesModel({
    required this.id,
    this.buddyStatus,
  });

  static UserStatesModel fromJson(Map<String, dynamic> json) => _$UserStatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserStatesModelToJson(this);

  UserStatesModel copyWith({
    BuddyStatus? buddyStatus,
  }) =>
      UserStatesModel(id: id, buddyStatus: buddyStatus ?? this.buddyStatus);
}
