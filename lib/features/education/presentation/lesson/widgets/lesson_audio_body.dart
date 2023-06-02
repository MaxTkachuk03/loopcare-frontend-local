import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/outlined_rounded_button.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/education/presentation/lesson/widgets/audio_block.dart';
import 'package:loopcare_frontend/features/education/subtitle/domain/image_subtitle_controller.dart';

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
  late SubtitleController _subtitleController;

  String? imageUrl;

  int position = 0;
  int duration = 0;
  bool isPlay = false;

  @override
  void initState() {
    prepareSubtitleController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  prepareSubtitleController() async {
    final subtitleFile = await rootBundle.loadString('assets/subtitle.txt');

    _subtitleController = SubtitleController.string(subtitleFile);
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

    if (duration > 0) {
      String text = _subtitleController.textFromMilliseconds(
          position, _subtitleController.subtitles);
      if (imageUrl != text) {
        setState(() {
          imageUrl = text;
        });
      }
    }
  }

  _setIsPlay(bool state) {
    setState(() {
      isPlay = state;
    });
  }

  void _onReadText() {
    context.router.pushNamed(AppRoutes.educationAudioTextVersion);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationLessonBloc, EducationLessonState>(
      builder: (context, state) {
        context.read<EducationLessonBloc>().add(
              EducationLessonEvent.downloadFile(
                state.data.currentPage.content.url,
              ),
            );

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: widget.onPrevPressed,
            ),
          ),
          body: SafeArea(
            child: MainContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        AnimatedOpacity(
                          opacity: isPlay ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: SizedBox(
                            height: 600,
                            child: imageUrl != null && imageUrl != ''
                                ? NetworkImageWithCache(url: imageUrl!)
                                : null,
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: isPlay ? 0.0 : 1.0,
                          duration: const Duration(milliseconds: 300),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 350,
                                child: NetworkImageWithCache(
                                  url: state.data.lessonImage,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  LocalizedTexts.general.translation
                                      .toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontSize: ThemeConstants.fontSize12,
                                        color: AppColors.orangeDark,
                                      ),
                                ),
                              ),
                              const SizedBox(height: 14),
                              Expanded(
                                child: Text(
                                  LocalizedTexts.sampleLessonText.translation,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                        fontFamily:
                                            ThemeConstants.bitterFontFamily,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedRoundedButton(
                    text: LocalizedTexts.readText.translation,
                    onPressed: _onReadText,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AudioBlock(
                      url: state.data.currentPage.content.url,
                      onDurationChanged: (int duration) {
                        _setDuration(duration);
                      },
                      onPositionChanged: (int position) {
                        _setPosition(position);
                      },
                      onPlayingChanged: (bool isPlay) {
                        _setIsPlay(isPlay);
                      },
                    ),
                  ),
                  // const SizedBox(height: 7),
                  // Visibility(
                  //   visible: !state.data.isLastPage,
                  //   child: ElevatedButton(
                  //     onPressed: widget.onNextPressed,
                  //     child: Text(LocalizedTexts.next.translation),
                  //   ),
                  // ),
                  const SizedBox(height: 14),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
