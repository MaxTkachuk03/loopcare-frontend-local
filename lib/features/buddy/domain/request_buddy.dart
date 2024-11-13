import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_buddy.g.dart';

@immutable
@JsonSerializable()
class RequestBuddy {
  final String? email;
  final bool liveTogether;
  final String relation;

  factory RequestBuddy.fromJson(Map<String, dynamic> json) => _$RequestBuddyFromJson(json);

  const RequestBuddy({this.email, required this.liveTogether, required this.relation});

  Map<String, dynamic> toJson() => _$RequestBuddyToJson(this);
}
