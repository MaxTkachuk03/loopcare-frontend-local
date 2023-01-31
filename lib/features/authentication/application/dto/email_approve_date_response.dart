import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email_approve_date_response.g.dart';

@immutable
@JsonSerializable()
class EmailApproveDateResponse {
  final String? emailApproveDate;

  const EmailApproveDateResponse(this.emailApproveDate);

  static EmailApproveDateResponse fromJson(Map<String, dynamic> json) =>
      _$EmailApproveDateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EmailApproveDateResponseToJson(this);
}
