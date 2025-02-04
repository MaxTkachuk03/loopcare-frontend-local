import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_commitment_response.freezed.dart';

part 'get_commitment_response.g.dart';

@freezed
class GetCommitmentResponse with _$GetCommitmentResponse {
  const GetCommitmentResponse._();

  const factory GetCommitmentResponse({
    required int completedCommitments,
    required int totalCommitments,
    required bool isCommitmentUnlocked,
    required bool showCommitmentWidget,
  }) = _GetCommitmentResponse;

  factory GetCommitmentResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCommitmentResponseFromJson(json);
}
