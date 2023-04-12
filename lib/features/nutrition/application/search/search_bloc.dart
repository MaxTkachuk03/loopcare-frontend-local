import 'dart:async';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/meals/dto/meals_list_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/select_serving/dto/food_item_serving.dart';

part 'search_event.dart';

part 'search_state.dart';

part 'search_bloc.freezed.dart';

@singleton
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final NutritionService nutritionService;

  SearchBloc(this.nutritionService) : super(const SearchState.initial()) {
    on<Search>(_onSearch);
  }

  FutureOr<void> _onSearch(
    Search event,
    Emitter<SearchState> emit,
  ) async {
    emit(const SearchState.loading());

    final response = await nutritionService.search(event.query, event.limit);

    response.fold(
      (error) {
        emit(SearchState.error(error));
      },
      (response) {
        emit(
          SearchState.result(
            items: response.data.toIList(),
          ),
        );
      },
    );
  }
}
