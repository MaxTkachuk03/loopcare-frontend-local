import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/clippers/education_clipper.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_technique.dart';
import 'package:loopcare_frontend/features/mind/application/mind_bloc.dart';

class TechniquesListTile extends StatefulWidget {
  const TechniquesListTile({
    super.key,
    required this.technique,
  });

  final MindTechnique technique;

  @override
  State<TechniquesListTile> createState() => _TechniquesListTileState();
}

class _TechniquesListTileState extends State<TechniquesListTile> {
  late bool isLocked;
  late final bool enableTimer;
  Timer? timer;

  void startTimer() {
    if (!enableTimer || !isLocked) {
      return;
    }

    timer?.cancel();

    timer = Timer.periodic(const Duration(minutes: 1), checkTime);
  }

  void checkTime(Timer value) {
    if (DateTime.now().toUtc().isAfter(widget.technique.unlocksAt!)) {
      setState(() {
        timer?.cancel();
        isLocked = false;
      });
    }
  }

  void onTechniqueSelect() =>
      context.read<MindBloc>().add(MindEvent.getExercises(techniqueId: widget.technique.id));

  @override
  void initState() {
    super.initState();
    isLocked = widget.technique.isLocked;
    enableTimer = widget.technique.unlocksAt != null;

    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Opacity(
            opacity: isLocked ? 0.5 : 1.0,
            child: ClipPath(
              clipper: ImageClipper(),
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(10),
                ),
                child: SizedBox(
                  width: 120.0,
                  child: NetworkImageWithCache(url: widget.technique.image),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.bitter600(
                widget.technique.title,
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 10),
              _AccessExercisesLine(
                date: widget.technique.unlocksAt,
                isLocked: isLocked,
                onPressed: onTechniqueSelect,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _AccessExercisesLine extends StatelessWidget {
  const _AccessExercisesLine({
    required this.date,
    required this.isLocked,
    required this.onPressed,
  });

  final DateTime? date;
  final bool isLocked;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    if (date == null && isLocked) {
      return Row(
        children: [
          AppIcons.locked,
          const SizedBox(width: 8.0),
          CustomText.w600(
            LocalizedTexts.lock.tr(),
            style: context.textTheme.bodySmall,
          ),
        ],
      );
    } else if (date != null && isLocked) {
      return Row(
        children: [
          AppIcons.locked,
          const SizedBox(width: 8.0),
          CustomText.w600(
            LocalizedTexts.unlocksOn.tr(
              args: [DateFormat(DateFormat.MONTH_DAY).format(date!)],
            ),
            style: context.textTheme.bodySmall,
          ),
        ],
      );
    } else {
      return CustomElevatedButton.yellowSmall(
        label: LocalizedTexts.exercises.tr(),
        onPressed: onPressed,
      );
    }
  }
}
