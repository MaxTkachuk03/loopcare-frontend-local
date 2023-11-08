import 'dart:async';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';
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
    on<GetPlannedMeals>(_onGetPlannedMeals);
    on<SetCurrentDate>(_onSetCurrentDate);
    on<FetchMealById>(_onFetchMealById);
  }

  FutureOr<void> _onFetchMealById(
    FetchMealById event,
    Emitter<ChooseDateState> emit,
  ) async {
    final response = await nutritionService.getPlannedMealById(event.id);

    response.fold(
      (l) => emit(ChooseDateState.error(state.data.copyWith(error: l))),
      (r) => emit(
        state.copyWith(
          data: state.data.copyWith(
            plannedMeals: _combinePlannedMealsByDate(state.data.plannedMeals, [r]),
          ),
        ),
      ),
    );
  }

  Map<String, List<MealsListItem>> _combinePlannedMealsByDate(
    Map<String, List<MealsListItem>>? previousMealsData,
    List<MealsListItem> data,
  ) {
    Map<String, List<MealsListItem>> meals = Map<String, List<MealsListItem>>.from(previousMealsData ?? {});

    for (var element in data) {
      final loggingDates = element.planningDates;
      if (loggingDates == null) continue;

      for (var i = 0; i < loggingDates.length; i++) {
        var loggingDate = loggingDates[i].isoStringWithoutTime;
        List<MealsListItem> dayData = meals[loggingDate] ?? <MealsListItem>[];
        final isAlreadyExist = dayData.contains(element);
        if (isAlreadyExist) continue;

        dayData.add(element);
        meals[loggingDate] = dayData;
      }
    }

    return meals;
  }

  FutureOr<void> _onSetCurrentDate(
    SetCurrentDate event,
    Emitter<ChooseDateState> emit,
  ) async {
    emit(
      state.copyWith(
        data: state.data.copyWith(
          currentDate: event.currentDate,
        ),
      ),
    );
  }

  FutureOr<void> _onGetPlannedMeals(
    GetPlannedMeals event,
    Emitter<ChooseDateState> emit,
  ) async {
    final response = await nutritionService.getPlannedMeals(
      startDate: event.startDate.beginDay.toIso8601String(),
      endDate: event.endDate.endDay.toIso8601String(),
    );

    response.fold(
      (l) => emit(ChooseDateState.error(state.data.copyWith(error: l))),
      (r) => emit(
        state.copyWith(
          data: state.data.copyWith(
            plannedMeals: _combinePlannedMealsByDate({}, r.data),
          ),
        ),
      ),
    );
    emit(
      state.copyWith(
        data: state.data.copyWith(
          selectedDateList: state.data.initSelectedDateList,
          originSelectedDateList: state.data.initSelectedDateList,
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

  FutureOr<void> _onSelectDate(
    SelectDate event,
    Emitter<ChooseDateState> emit,
  ) async {
    var selectedDates = state.data.selectedDateList.toList();
    for (var i = 0; i < event.dates.length; i++) {
      var date = event.dates[i];

      if (date.isContainedIn(state.data.filledDateList) &&
          !date.isContainedIn(selectedDates) &&
          !event.confirmed) {
        emit(state.copyWith(data: state.data.copyWith(showReplaceWarning: false)));

        emit(
          state.copyWith(
            data: state.data.copyWith(
              showReplaceWarning: true,
              warningDate: date,
            ),
          ),
        );
        return;
      } else {
        emit(
          state.copyWith(
            data: state.data.copyWith(
              showReplaceWarning: false,
              warningDate: null,
            ),
          ),
        );
      }

      if (date.isContainedIn(selectedDates)) {
        selectedDates.removeAt(date.containedIndex(selectedDates));
      } else {
        selectedDates.add(date);
      }
    }
    if (selectedDates.isEmpty) {
      emit(state.copyWith(data: state.data.copyWith(showSaveWarning: false)));
      emit(state.copyWith(data: state.data.copyWith(showSaveWarning: true)));
    } else {
      emit(
        state.copyWith(
          data: state.data.copyWith(
            selectedDateList: selectedDates,
            canSave: isNotIdentical(selectedDates, state.data.originSelectedDateList),
            showSaveWarning: false,
            showReplaceWarning: false,
            warningDate: null,
          ),
        ),
      );

      emit(state.copyWith(data: state.data.copyWith(weekDayElementList: state.data.weeks)));
    }
  }

  FutureOr<void> _onSetData(
    SetData event,
    Emitter<ChooseDateState> emit,
  ) async {
    emit(
      ChooseDateState.calendar(
        state.data.copyWith(
          mealCategory: event.mealCategory,
          currentDate: event.dates?.first,
          currentMealId: event.currentMealId,
          showSaveWarning: false,
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

  FutureOr<void> _onInit(
    Init event,
    Emitter<ChooseDateState> emit,
  ) async {
    emit(
      ChooseDateState.calendar(
        state.data.copyWith(
          weekDayElementList: state.data.weeks,
          showSaveWarning: false,
        ),
      ),
    );
  }
}
