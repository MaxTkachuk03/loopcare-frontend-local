import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_icon_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';

class LongAnswerTextAreaItem extends StatelessWidget {
  const LongAnswerTextAreaItem({
    super.key,
    required this.text,
    required this.isButtonDisabled,
    required this.successText,
    required this.controller,
    required this.focusNode,
    required this.dateTime,
    required this.lessonStreamType,
    this.clearTextHandler,
    this.editTextHandler,
    required this.onSaveHandler,
    this.onChangeHandler,
    required this.readOnly,
    this.maxLength,
  });

  final String text;
  final bool isButtonDisabled;
  final String successText;
  final TextEditingController controller;
  final int? maxLength;
  final FocusNode focusNode;
  final DateTime dateTime;
  final RiverModuleStreamType lessonStreamType;
  final bool readOnly;
  final void Function(String)? onChangeHandler;
  final void Function()? clearTextHandler;
  final void Function()? editTextHandler;
  final void Function(String text) onSaveHandler;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: key,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: 1.0, style: BorderStyle.solid),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    "${dateTime.isoStringWithoutTime} ${dateTime.timeHoursMinutes24}",
                    style: context.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              TextField(
                clipBehavior: Clip.hardEdge,
                readOnly: readOnly,
                maxLines: 3,
                maxLength: maxLength,
                controller: controller,
                focusNode: focusNode,
                onChanged: onChangeHandler,
                decoration: InputDecoration(
                    hintText: "Type your answer here.",
                    focusedBorder: InputBorder.none,
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    hintStyle: const TextStyle(color: AppColors.black),
                    fillColor: lessonStreamType.lightestColor,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 20)),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    CustomIconButton.custom(
                      onPressed: readOnly ? clearTextHandler : null,
                      icon: AppIcons.interactiveLessonBucket(readOnly,
                          lessonStreamType.regularColor, AppColors.greyLighter),
                    ),
                    CustomIconButton.custom(
                      onPressed: readOnly ? editTextHandler : null,
                      icon: AppIcons.interactiveLessonEditPencil(readOnly,
                          lessonStreamType.regularColor, AppColors.greyLighter),
                    ),
                    const Spacer(),
                    CustomElevatedButton(
                      onPressed: text.isEmpty || !isButtonDisabled
                          ? null
                          : () {
                              onSaveHandler(controller.text);
                            },
                      styles: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              text.isEmpty || !isButtonDisabled
                                  ? null
                                  : lessonStreamType.regularColor)),
                      label: successText.isNotEmpty ? '   ✓  ' : 'Save',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
