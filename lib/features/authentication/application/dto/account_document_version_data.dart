import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_document_version_data.g.dart';

@immutable
@JsonSerializable()
class AccountDocumentVersionData {
  final int? termsAndConditionsVersion;
  final int? privacyPolicyVersion;

  const AccountDocumentVersionData({
    required this.termsAndConditionsVersion,
    required this.privacyPolicyVersion,
  });

  factory AccountDocumentVersionData.fromJson(Map<String, dynamic> json) =>
      _$AccountDocumentVersionDataFromJson(json);

  Map<String, dynamic> toJson() => _$AccountDocumentVersionDataToJson(this);
}
