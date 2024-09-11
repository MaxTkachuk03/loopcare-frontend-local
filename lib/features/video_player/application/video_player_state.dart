part of 'video_player_bloc.dart';

@freezed
class VideoPlayerState with _$VideoPlayerState {
  const factory VideoPlayerState.initial(VideoPlayerData data) = Initial;

  const factory VideoPlayerState.loading(VideoPlayerData data) = Loading;

  const factory VideoPlayerState.error(VideoPlayerData data) = Error;

  const factory VideoPlayerState.cookiesLoaded(VideoPlayerData data) = CookiesLoaded;
}

@freezed
class VideoPlayerData with _$VideoPlayerData {
  const VideoPlayerData._();

  const factory VideoPlayerData({
    @Default(AwsPresignedCookies()) AwsPresignedCookies awsCookies,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _VideoPlayerData;

  Map<String, String> get videoHttpHeaders {
    final String cookiesString =
        awsCookies.toJson().entries.map((e) => '${e.key}=${e.value}').join('; ');

    return {'Cookie': cookiesString};
  }
}
