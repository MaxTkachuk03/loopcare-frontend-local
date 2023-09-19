import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/rive_animation_renderer/rive_animation_renderer.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/progress_bar.dart';
import 'package:loopcare_frontend/features/account/domain/user_grouping_state.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_cubit.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_state.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/domain/extra_action_types.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/audio_block.dart';
import 'package:loopcare_frontend/features/education/domain/subtitle/image_subtitle_controller.dart';
import 'dart:io';

import 'package:loopcare_frontend/injection.dart';

// TODO refactor _subtitleController
class LessonAudioPage extends StatefulWidget {
  final void Function() onNextPressed;
  final void Function() onPrevPressed;

  const LessonAudioPage({
    Key? key,
    required this.onNextPressed,
    required this.onPrevPressed,
  }) : super(key: key);

  @override
  State<LessonAudioPage> createState() => _LessonAudioPageState();
}

class _LessonAudioPageState extends State<LessonAudioPage> {
  AppConfig appConfig = getIt<AppConfig>();
  late SubtitleController _subtitleController;
  bool _subtitleControllerInitialized = false;

  String? imageUrl;
  String? imageUrlFromJson;
  late int lessonId;

  int position = 0;
  int duration = 0;
  bool isPlay = false;
  bool isSvg = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  prepareSubtitleController(String path) async {
    final File file = File(path);
    final subtitleFile = await file.readAsString();

    _subtitleController = SubtitleController.string(subtitleFile);
    _subtitleControllerInitialized = true;
  }

  _setDuration(int v) {
    setState(() {
      duration = v;
    });
  }

  _setPosition(int v) {
    setState(() {
      position = v;
    });

    if (duration > 0 && _subtitleControllerInitialized) {
      String text = _subtitleController.textFromMilliseconds(
        position,
        _subtitleController.subtitles,
      );
      if (text.isNotEmpty && imageUrlFromJson != text) {
        setState(() {
          imageUrl = "${appConfig.baseUrl}/education/content/$lessonId/$text";
          imageUrlFromJson = text;
          if (text.contains('.svg')) {
            context.read<EducationLessonBloc>().add(EducationLessonEvent.downloadSVGFile(imageUrl!));
            isSvg = true;
          } else {
            isSvg = false;
          }
        });
      } else if (text.isEmpty) {
        setState(() {
          imageUrl = null;
          imageUrlFromJson = text;
        });
      }
    }
  }

  _setIsComplete() {
    widget.onNextPressed();
  }

  _setIsPlay(bool state) {
    setState(() {
      isPlay = state;
    });
  }

  void _onReadText() {
    ModalBottomSheet.readTextVersion(
      context: context,
      onBtnPress: widget.onNextPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationLessonBloc, EducationLessonState>(
      builder: (context, state) {
        if (state.data.currentPage.content.subtitleFilePath.isNotEmpty) {
          prepareSubtitleController(state.data.currentPage.content.subtitleFilePath);
        }
        lessonId = state.data.lessonId;

        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: widget.onPrevPressed,
            ),
          ),
          body: Stack(
            children: [
              const SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: RiveAnimationRenderer(),
              ),
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BlocBuilder<AuthenticationCubit, AuthenticationState>(
                      builder: (context, accountState) {
                        return BlocBuilder<EducationLessonBloc, EducationLessonState>(
                          builder: (context, state) {
                            if (state.data.extraAction == ExtraActionTypes.setupGroupingPreferences &&
                                accountState.groupingState == UserGroupingState.locked) {
                              return ProgressBar(
                                progress: state.data.lessonProgress,
                              );
                            }

                            return const SizedBox.shrink();
                          },
                        );
                      },
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          AnimatedOpacity(
                            opacity: isPlay ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 300),
                            child: Center(
                              child: SizedBox(
                                height: 600,
                                child: imageUrl != null && imageUrl != ''
                                    ? isSvg
                                        ? state.data.isSvgLoaded
                                            ? SvgPicture.file(File(state.data.svgFile))
                                            : null
                                        : NetworkImageWithCache(
                                            withPlaceholder: false,
                                            url: imageUrl!,
                                            imageBoxFit: BoxFit.contain,
                                          )
                                    : null,
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            opacity: isPlay ? 0.0 : 1.0,
                            duration: const Duration(milliseconds: 300),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 270,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                    child: NetworkImageWithCache(
                                      imageBoxFit: BoxFit.contain,
                                      url: state.data.lessonImage,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      LocalizedTexts.general.translation.toUpperCase(),
                                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                            fontSize: ThemeConstants.fontSize12,
                                            color: AppColors.orangeDark,
                                          ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: AutoSizeText(
                                      state.data.lessonTitle,
                                      maxLines: 2,
                                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                            fontFamily: ThemeConstants.bitterFontFamily,
                                          ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0,
                                    ),
                                    width: 250,
                                    child: OutlinedButton(
                                      onPressed: _onReadText,
                                      child: Center(
                                        child: AutoSizeText(
                                          LocalizedTexts.readText.translation,
                                          minFontSize: 6,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (state.data.currentPage.content.audioFilePath.isNotEmpty)
                      AudioBlock(
                        url: state.data.currentPage.content.audioFilePath,
                        duration: state.data.lessonDuration,
                        onDurationChanged: (int duration) {
                          _setDuration(duration);
                        },
                        onPositionChanged: (int position) {
                          _setPosition(position);
                        },
                        onPlayingChanged: (bool isPlay) {
                          _setIsPlay(isPlay);
                        },
                        onPlayerComplete: () => _setIsComplete(),
                      ),
                    const SizedBox(height: 14),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
