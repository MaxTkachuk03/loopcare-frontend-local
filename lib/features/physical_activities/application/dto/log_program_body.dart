import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_program_body.freezed.dart';

part 'log_program_body.g.dart';

@freezed
abstract class LogProgramBody implements _$LogProgramBody {
  const LogProgramBody._();

  const factory LogProgramBody({
    required int physicalProgramId,
    required int score,
    required bool like,
  }) = _LogProgramBody;

  factory LogProgramBody.fromJson(Map<String, dynamic> json) => _$LogProgramBodyFromJson(json);
}
