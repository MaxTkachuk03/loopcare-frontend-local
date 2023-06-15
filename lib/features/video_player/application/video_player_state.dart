part of 'video_player_bloc.dart';

@freezed
class VideoPlayerState with _$VideoPlayerState {
  const factory VideoPlayerState.initial(VideoPlayerData data) = _Initial;

  const factory VideoPlayerState.loading(VideoPlayerData data) = _Loading;

  const factory VideoPlayerState.error(VideoPlayerData data) = _Error;

  const factory VideoPlayerState.cookiesLoaded(VideoPlayerData data) = _CookiesLoaded;
}

@freezed
class VideoPlayerData with _$VideoPlayerData {
  const factory VideoPlayerData({
    @Default([]) List<String> awsCookies,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _VideoPlayerData;
}
