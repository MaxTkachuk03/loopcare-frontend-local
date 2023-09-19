import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanle_event_service.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:video_player/video_player.dart';

class VideoBlock extends StatelessWidget {
  static const double _defaultVideoWidth = 1280.0;
  static const double _defaultVideoHeight = 720.0;

  final Orientation orientation;
  final VideoPlayerController? controller;
  final Widget Function(double width, double height, String? error) errorWidget;

  const VideoBlock({
    Key? key,
    required this.orientation,
    required this.controller,
    required this.errorWidget,
  }) : super(key: key);

  double get _videoWidth {
    final width = controller?.value.size.width;

    return width != 0 && width != null ? width : _defaultVideoWidth;
  }

  double get _videoHeight {
    final height = controller?.value.size.height;

    return height != 0 && height != null ? height : _defaultVideoHeight;
  }

  @override
  Widget build(BuildContext context) {
    return controller != null
        ? ValueListenableBuilder(
            valueListenable: controller!,
            builder: (BuildContext context, VideoPlayerValue value, child) {
              if (value.hasError) {
                final userId = context.read<AuthenticationCubit>().state.id;
                MixpanelEventService.instance.track(
                  AppMixpanelEvents.videoBlockFail,
                  {
                    'userId': userId,
                    'error': value.errorDescription ?? '',
                  },
                );
                return errorWidget(_videoWidth, _videoHeight, value.errorDescription);
              }

              if (!value.isInitialized) return const Center(child: Loader());

              return FittedBox(
                fit: orientation == Orientation.portrait ? BoxFit.fitWidth : BoxFit.fitHeight,
                child: SizedBox(
                  width: _videoWidth,
                  height: _videoHeight,
                  child: AspectRatio(
                    aspectRatio: value.aspectRatio,
                    child: VideoPlayer(controller!),
                  ),
                ),
              );
            },
          )
        : const Center(child: Loader());
  }
}
