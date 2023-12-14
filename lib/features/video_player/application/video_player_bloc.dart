import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/application/aws_service.dart';
import 'package:loopcare_frontend/core/domain/aws_cookies_type.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/physical_activities/domain/aws_presigned_cookies.dart';

part 'video_player_bloc.freezed.dart';
part 'video_player_event.dart';
part 'video_player_state.dart';

@singleton
class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  final AwsService _awsService;

  VideoPlayerBloc(this._awsService) : super(const VideoPlayerState.initial(VideoPlayerData())) {
    on<GetAwsCookies>(_onGetAwsCookies);
  }

  Future<void> _onGetAwsCookies(
    GetAwsCookies event,
    Emitter<VideoPlayerState> emit,
  ) async {
    emit(
      VideoPlayerState.loading(
        state.data.copyWith(
          isLoading: true,
          error: null,
        ),
      ),
    );

    final response = await _awsService.getAwsCookies(event.type);

    response.fold(
      (l) => emit(VideoPlayerState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) {
        emit(
          VideoPlayerState.cookiesLoaded(
            state.data.copyWith(
              awsCookies: r.data,
              isLoading: false,
              error: null,
            ),
          ),
        );
      },
    );
  }
}
