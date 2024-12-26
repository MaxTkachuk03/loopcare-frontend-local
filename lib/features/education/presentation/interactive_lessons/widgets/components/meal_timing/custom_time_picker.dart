import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/presentation/interactive_lessons/widgets/continue_btn.dart';
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
            padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: AppColors.bgGreen,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "Select your time",
                  style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
                ),
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      CupertinoDatePicker(
                        initialDateTime: widget.initialTime,
                        onDateTimeChanged: (DateTime value) {
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