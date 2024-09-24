import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/app_bar/custom_app_bar.dart';
import 'package:loopcare_frontend/core/presentation/bottom_placed_button/bottom_placed_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_filled_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scoring_scale.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class MindRatingScreen extends StatefulWidget {
  const MindRatingScreen({
    super.key,
    required this.title,
    required this.question,
    required this.isFinish,
    required this.onCompleted,
    this.highestText,
    this.lowestText,
  });

  final String title;
  final String question;
  final String? lowestText;
  final String? highestText;
  final bool isFinish;
  final void Function() onCompleted;

  @override
  State<MindRatingScreen> createState() => _MindRatingScreenState();
}

class _MindRatingScreenState extends State<MindRatingScreen> {
  final ValueNotifier<int?> _scoreListener = ValueNotifier(null);

  void _onNextPressed(int? value) {
    context.read<MindBloc>().add(
          MindEvent.addRating(
            value: value,
            isAfter: widget.isFinish,
          ),
        );

    widget.onCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MindBloc, MindState>(
      listener: (context, state) {
        if (widget.isFinish) {
          _scoreListener.value = state.data.scaleAfterAnswer;
        } else {
          _scoreListener.value = state.data.scaleBeforeAnswer;
        }
      },
      child: CustomScaffold.petrol(
        appBar: CustomAppBar.petrol(
          title: widget.title,
          leading: CustomFilledIconButton.leadingPetrolLighter(),
        ),
        body: BottomPlacedButton.petrol(
          body: MainContainer(
            child: Column(
              children: [
                const Spacer(flex: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomText.bitter400(
                    widget.question,
                    style: context.textTheme.displayLarge
                        ?.copyWith(color: AppColors.white, height: 1.3),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 48),
                Container(
                  height: 66,
                  alignment: Alignment.center,
                  child: ValueListenableBuilder<int?>(
                    valueListenable: _scoreListener,
                    builder: (context, value, _) => ScoringScale(
                      selectedScore: value,
                      selectedColor: AppColors.yellowOffRegular,
                      textColor: AppColors.white,
                      scaleSize: 11,
                      labels: List.generate(11, (index) => index.toString()),
                      borderColor: AppColors.white,
                      divColor: AppColors.white,
                      onScoreTap: (tabIndex) => _scoreListener.value = tabIndex,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText.w600(
                      widget.lowestText ?? '',
                      style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white),
                    ),
                    CustomText.w600(
                      widget.highestText ?? '',
                      style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white),
                    ),
                  ],
                ),
                const Spacer(flex: 5),
              ],
            ),
          ),
          button: ValueListenableBuilder<int?>(
            valueListenable: _scoreListener,
            builder: (context, value, _) {
              return CustomElevatedButton.yellowFullWidth(
                onPressed: value != null ? () => _onNextPressed(value) : null,
                label:
                    widget.isFinish ? LocalizedTexts.next.tr() : LocalizedTexts.startExercise.tr(),
              );
            },
          ),
        ),
      ),
    );
  }
}
