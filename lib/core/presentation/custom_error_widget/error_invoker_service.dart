import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

part 'error_invoker_service.freezed.dart';

@freezed
abstract class ErrorServiceEvent with _$ErrorServiceEvent {
  const ErrorServiceEvent._();

  const factory ErrorServiceEvent.throwArtificialError() = ThrowArtificialError;

  const factory ErrorServiceEvent.clean() = CleanErrorEvents;
}

@singleton
class ErrorInvokeService {
  final _behaviorSubject = BehaviorSubject<ErrorServiceEvent>();

  Stream<ErrorServiceEvent> get steam => _behaviorSubject.stream;

  void throwArtificialError() =>
      _behaviorSubject.add(const ErrorServiceEvent.throwArtificialError());

  void clean() => _behaviorSubject.add(const ErrorServiceEvent.clean());
}
