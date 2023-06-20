import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class LikeUnlikeBlock extends StatefulWidget {
  final bool? like;
  final void Function(bool like) onLikeChange;

  const LikeUnlikeBlock({
    Key? key,
    required this.like,
    required this.onLikeChange,
  }) : super(key: key);

  @override
  State<LikeUnlikeBlock> createState() => _LikeUnlikeBlockState();
}

class _LikeUnlikeBlockState extends State<LikeUnlikeBlock> {
  int selectedThumb = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.yellowLight),
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SizedBox(
                width: 101,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () => _onThumbsTap(-1),
                      icon: Icon(
                        Icons.thumb_down_rounded,
                        color: (selectedThumb == -1)
                            ? AppColors.blueMid
                            : AppColors.yellowLight,
                        size: 34,
                      ),
                    ),
                    Text(
                      LocalizedTexts.notReally.translation,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: (selectedThumb == -1)
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SizedBox(
                width: 101,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () => _onThumbsTap(1),
                      icon: Icon(
                        Icons.thumb_up_rounded,
                        color: (selectedThumb == 1)
                            ? AppColors.blueMid
                            : AppColors.yellowLight,
                        size: 34,
                      ),
                    ),
                    Text(
                      LocalizedTexts.yesYes.translation,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: (selectedThumb == 1)
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onThumbsTap(int like) {
    setState(() {
      selectedThumb = like;
      widget.onLikeChange(like == 1);
    });
  }
}
