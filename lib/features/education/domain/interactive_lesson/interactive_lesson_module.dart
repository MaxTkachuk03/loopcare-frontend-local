import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';

part 'interactive_lesson_module.freezed.dart';
part 'interactive_lesson_module.g.dart';

@freezed
class InteractiveLessonModule with _$InteractiveLessonModule {
  const InteractiveLessonModule._();

  const factory InteractiveLessonModule({
    required int id,
    required int externalModuleId,
  }) = _InteractiveLessonModule;

  factory InteractiveLessonModule.fromJson(Map<String, dynamic> json) =>
      _$InteractiveLessonModuleFromJson(json);

  factory InteractiveLessonModule.debugFromJson(Map<String, dynamic> json) {
    try {
      log.d('Parsing InteractiveLessonModule: $json');
      return InteractiveLessonModule(
        id: json['id'] as int,
        externalModuleId: json['externalModuleId'] as int,
      );
    } catch (e, stackTrace) {
      log.d('Error in InteractiveLessonModule.fromJson: $e');
      log.d('Stack Trace: $stackTrace');
      log.d('Problematic JSON: $json');
      rethrow; // Rethrow to propagate the error up the stack
    }
  }
}
