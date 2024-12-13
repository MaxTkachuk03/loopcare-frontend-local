part of 'bmr_bloc.dart';

@freezed
class BmrEvent with _$BmrEvent {
  const factory BmrEvent.getBmr({required DateTime date}) = GetBmr;
}
