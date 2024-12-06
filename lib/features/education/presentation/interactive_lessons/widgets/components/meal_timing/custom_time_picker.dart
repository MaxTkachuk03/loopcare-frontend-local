import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/animations/lottie_animation.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/continue_btn.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';

class CustomTimePicker extends StatefulWidget {
  const CustomTimePicker({
    super.key,
    required this.initialTime,
  });

  final DateTime initialTime;

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  DateTime newTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return BlocBuilder<MealsBloc, MealsState>(
      builder: (context, state) {
        return Center(
          child: Container(
            height: height / 2.5,
            width: width / 1.15,
            padding:
                const EdgeInsets.symmetric(vertical: 26.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: AppColors.bgGreen,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "Select your time",
                  style: context.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      CupertinoDatePicker(
                        initialDateTime: widget.initialTime,
                        onDateTimeChanged: (DateTime value) {
                          print("value: $value");
                          // state.
                          newTime = value;
                        },
                        mode: CupertinoDatePickerMode.time,
                      ),
                      Container(
                        height: 35,
                        width: width / 1.15,
                        decoration: BoxDecoration(
                          color: AppColors.greenMid.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                      ),
                    ],
                  ),
                ),
                ContinueBtn(
                    bottom: 0,
                    onPressed: () {
                      context.read<MealsBloc>().add(MealsEvent.setCurrentDate(newTime));
                      context.router.maybePop(context);
                    },
                    isDisable: false),
              ],
            ),
          ),
        );
      },
    );
  }
}


/*

 Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              "Select your time",
              style: context.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            Container(
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.greenLight, // Світлий фон пікера
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Години
                  Expanded(
                    child: CupertinoPicker(
                      selectionOverlay:
                          const CupertinoPickerDefaultSelectionOverlay(
                        background: Colors.transparent,
                      ),
                      squeeze: 2,
                      diameterRatio: 5,
                      scrollController: FixedExtentScrollController(
                          initialItem: widget.selectedHour - 1),
                      itemExtent: 40,
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          widget.selectedHour = index + 1;
                        });
                      },
                      children: List<Widget>.generate(12, (int index) {
                        return Center(
                          child: CustomText.w400(
                            "${index + 1}",
                            style: context.textTheme.displayMedium,
                          ),
                        );
                      }),
                    ),
                  ),
                  // Хвилини
                  Expanded(
                    child: CupertinoPicker(
                      selectionOverlay:
                          const CupertinoPickerDefaultSelectionOverlay(
                        background: Colors.transparent,
                      ),
                      scrollController: FixedExtentScrollController(
                          initialItem: widget.selectedMinute),
                      itemExtent: 40,
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          widget.selectedMinute = index;
                        });
                      },
                      children: List<Widget>.generate(60, (int index) {
                        return Center(
                          child: CustomText.w400(
                            "${index.toString().padLeft(2, '0')}",
                            style: context.textTheme.displayMedium,
                          ),
                        );
                      }),
                    ),
                  ),
                  // AM/PM
                  Expanded(
                    child: CupertinoPicker(
                      selectionOverlay:
                          const CupertinoPickerDefaultSelectionOverlay(
                        background: Colors.transparent,
                      ),
                      scrollController: FixedExtentScrollController(
                          initialItem: widget.selectedPeriod == "AM" ? 0 : 1),
                      itemExtent: 40,
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          widget.selectedPeriod = index == 0 ? "AM" : "PM";
                        });
                      },
                      children: ["AM", "PM"].map((e) {
                        return Center(
                          child: CustomText.w400(
                            e,
                            style: context.textTheme.displayMedium,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25.0),
            ContinueBtn(
                onPressed: () {
                   print("Selected Time: ${widget.selectedHour}:${{widget.selectedMinute}.toString().padLeft(2, '0')} ${widget.selectedPeriod}");
                  context.router.maybePop(context);
                },
                isDisable: false),
          ],
        ),
*/