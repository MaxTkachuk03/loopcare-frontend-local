import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/subtitle/audio_subtitle.dart';
import 'package:loopcare_frontend/features/education/domain/subtitle/image_subtitle_controller.dart';
import 'package:loopcare_frontend/injection.dart';

final AppConfig appConfig = getIt<AppConfig>();
final storage = getIt<SharedStorageService>();

class ImageSubtitles extends StatefulWidget {
  final SubtitleController controller;

  const ImageSubtitles({super.key, required this.controller});

  @override
  State<ImageSubtitles> createState() => _ImageSubtitlesState();
}

class _ImageSubtitlesState extends State<ImageSubtitles> {
  @override
  void initState() {
    super.initState();

    _parseSubTitleFile();
  }

  _parseSubTitleFile() async {
    final path = context.read<EducationLessonBloc>().state.data.subtitleFilePath;

    final subtitleFile = await File(path).readAsString();

    widget.controller.setSubtitlesFile(subtitleFile);
  }

  String _getSubtitleImagePath(int lessonId, String src) =>
      "${appConfig.baseUrl}/education/content/$lessonId/$src";

  Map<String, String> get _headers =>
      {"Authorization": 'Bearer ${storage.getString('access_token')}'};

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AudioSubtitle?>(
      valueListenable: widget.controller.activeSubtitleItem,
      builder: (context, activeSubtitleItem, _) {
        final int lessonId = context.read<EducationLessonBloc>().state.data.id;
        final path = _getSubtitleImagePath(lessonId, activeSubtitleItem?.src ?? '');

        return widget.controller.hasActiveSubtitleItem
            ? SvgPicture.network(
                fit: BoxFit.fitHeight,
                headers: _headers,
                path,
                placeholderBuilder: (BuildContext context) =>
                    Container(padding: const EdgeInsets.all(30.0), child: const Loader()),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
