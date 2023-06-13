import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/physical_activities/presentation/select_exercise/widgets/custom_exercise_field.dart';

class CustomActivityTab extends StatefulWidget {
  const CustomActivityTab({Key? key}) : super(key: key);

  @override
  State<CustomActivityTab> createState() => _CustomActivityTabState();
}

class _CustomActivityTabState extends State<CustomActivityTab> {
  bool isDisabledButton = true;

  @override
  Widget build(BuildContext context) {
    return ScrollableContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocalizedTexts.whatPhysicalActivityDidYouDo,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ).tr(),
              const SizedBox(
                height: 20.0,
              ),
              CustomExerciseField(
                onChanged: _onFieldChanged,
              )
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: isDisabledButton ? null : _onLogActivityPressed,
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return AppColors.greyMid;
                      }

                      return AppColors.orangeDark;
                    },
                  ),
                ),
                child: const Text(LocalizedTexts.logActivity).tr(),
              ),
              const SizedBox(
                height: 54.0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onLogActivityPressed() {}

  _onFieldChanged(String value) {
    setState(() {
      isDisabledButton = value.isEmpty;
    });
  }
}
