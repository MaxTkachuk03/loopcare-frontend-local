import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/buddy/domain/buddy_invitation.dart';

part 'buddy.freezed.dart';
part 'buddy.g.dart';

@freezed
abstract class Buddy implements _$Buddy {
  const Buddy._();

  const factory Buddy({
    required int id,
    required String username,
    required String? email,
    @Default('invited') String state,
    required BuddyInvitation? invitation,
    required DateTime? createdAt,
    required DateTime? updatedAt,
  }) = _Buddy;

  factory Buddy.fromJson(Map<String, dynamic> json) => _$BuddyFromJson(json);
}
