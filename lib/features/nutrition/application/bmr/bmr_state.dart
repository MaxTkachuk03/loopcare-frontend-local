part of 'bmr_bloc.dart';

@freezed
class BmrState with _$BmrState {
  const factory BmrState.initial(BmrStateData data) = BmrStateInitial;

  const factory BmrState.loading(BmrStateData data) = BmrStateLoading;

  const factory BmrState.bmrLoaded(BmrStateData data) = BmrStateLoaded;

  const factory BmrState.error(BmrStateData data) = BmrStateError;
}

@freezed
class BmrStateData with _$BmrStateData {
  const BmrStateData._();

  const factory BmrStateData({
    @Default(false) bool isLoading,
    @Default(0) double bmr,
    RequestError? error,
  }) = _BmrStateData;
}
