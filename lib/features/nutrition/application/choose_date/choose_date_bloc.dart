import 'dart:async';
import 'dart:math';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/meals_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/domain/choose_date/week_day_element.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/date_time_utils.dart';

part 'choose_date_event.dart';

part 'choose_date_state.dart';

part 'choose_date_bloc.freezed.dart';

@singleton
class ChooseDateBloc extends Bloc<ChooseDateEvent, ChooseDateState> {
  final NutritionService nutritionService;
  final MealsBloc mealsBloc;

  ChooseDateBloc(
    this.nutritionService,
    this.mealsBloc,
  ) : super(const ChooseDateState.initial(ChooseDateData())) {
    on<Init>(_onInit);
    on<SetData>(_onSetData);
    on<SelectDate>(_onSelectDate);
  }

  FutureOr<void> _onSelectDate(
    SelectDate event,
    Emitter<ChooseDateState> emit,
  ) async {
    var selectedDates = state.data.selectedDateList.toList();

    if (selectedDates.contains(event.date)) {
      selectedDates.remove(event.date);
    } else {
      selectedDates.add(event.date);
    }
    emit(
      state.copyWith(
        data: state.data.copyWith(
          selectedDateList: selectedDates,
        ),
      ),
    );

    emit(
      state.copyWith(
        data: state.data.copyWith(
          weekDayElementList: state.data.weeks,
        ),
      ),
    );
  }

  FutureOr<void> _onSetData(
    SetData event,
    Emitter<ChooseDateState> emit,
  ) async {
    emit(
      ChooseDateState.calendar(
        state.data.copyWith(
          mealCategory: event.mealCategory,
          date: event.date,
        ),
      ),
    );
  }

  FutureOr<void> _onInit(
    Init event,
    Emitter<ChooseDateState> emit,
  ) async {
    var filledPlannedMealDates = mealsBloc.state.filledPlannedMealDates;

    emit(
      ChooseDateState.calendar(
        state.data.copyWith(
          weekDayElementList: state.data.weeks,
          filledDateList: filledPlannedMealDates.map((e) => DateTime.parse(e)).toList(),
        ),
      ),
    );
  }
}
