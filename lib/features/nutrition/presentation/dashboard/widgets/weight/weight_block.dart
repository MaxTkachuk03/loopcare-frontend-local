import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/hexagon.dart';

class WeightBlock extends StatelessWidget {
  final DateTime date;

  final Duration _pastDuration = const Duration(days: 7);
  late final DateTime _todayMidnight;
  late final DateTime _selectedDateMidnight;
  late final bool _isToday;
  late final bool _isPastDate;
  late final bool _isLessThanSevenDaysPastDate;
  late final bool _isDisabled;
  late final bool _isEditable;

  WeightBlock({
    Key? key,
    required this.date,
  }) : super(key: key) {
    _todayMidnight = convertDateToMidnightTime(DateTime.now());
    _selectedDateMidnight = convertDateToMidnightTime(date);

    _isToday = _selectedDateMidnight == _todayMidnight;
    _isPastDate = _selectedDateMidnight.isBefore(_todayMidnight);
    _isLessThanSevenDaysPastDate =
        _todayMidnight.difference(_selectedDateMidnight) <= _pastDuration;
    _isDisabled = _isToday || (_isPastDate && _isLessThanSevenDaysPastDate);
    _isEditable = true;
  }

  DateTime convertDateToMidnightTime(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  void onPressHandler(BuildContext context) {
    // TODO do logic depends on editable weight block state
    context.router.pushNamed(AppRoutes.logWeight);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Image(
                image: AppIcons.dashboardWeight,
              ),
              const SizedBox(width: 24.0),
              // TODO get data from the user bloc
              Text(
                _isDisabled
                    ? LocalizedTexts.logYourWeight.translation
                    : "${LocalizedTexts.weight.translation} : 87,9 kg",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontFamily: ThemeConstants.bitterFontFamily,
                      color: _isDisabled
                          ? AppColors.darkGreen
                          : AppColors.greyLabel,
                    ),
              ),
            ],
          ),
          _isDisabled
              ? Hexagon(
                  width: 54,
                  height: 54,
                  borderRadius: 16,
                  innerWidget: Container(
                    color: AppColors.bgGreen,
                    child: IconButton(
                      icon: ImageIcon(
                        _isEditable ? AppIcons.edit : AppIcons.plus,
                        color: AppColors.darkGreen,
                        size: 18,
                      ),
                      onPressed: () => onPressHandler(context),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
