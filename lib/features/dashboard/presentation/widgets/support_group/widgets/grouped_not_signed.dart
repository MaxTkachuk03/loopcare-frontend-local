import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_outlined_button.dart';
import 'package:loopcare_frontend/core/presentation/clippers/education_clipper.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/network_image_with_cache/network_image_with_cache.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';

class GroupedNotSigned extends StatelessWidget {
  final String topicName;
  final String image;

  const GroupedNotSigned({
    super.key,
    required this.topicName,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.blueLighter, style: BorderStyle.solid),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        children: [
          ClipPath(
            clipper: ImageClipper(),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: SizedBox(
                width: 135,
                height: 200,
                child: NetworkImageWithCache(url: image),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, right: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  CustomText.w700(
                    topicName,
                    style: context.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10.0),
                  CustomOutlinedButton.coral(
                    label: LocalizedTexts.bookYourSeatNow.tr(),
                    onPressed: () => _onBookSeatPressed(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Flexible(
    //           child: CustomText.w600(
    //             topicName,
    //             style: context.textTheme.bodySmall,
    //           ),
    //         ),
    //       ],
    //     ),
    //     const SizedBox(height: 8.0),
    //     CustomOutlinedButton.coralFullWidth(
    //       label: LocalizedTexts.bookYourSeatNow.tr(),
    //       onPressed: () => _onBookSeatPressed(context),
    //     ),
    //   ],
    // );
  }

  _onBookSeatPressed(BuildContext context) {
    ModalBottomSheet.sessionsDialog(context: context);
  }
}
