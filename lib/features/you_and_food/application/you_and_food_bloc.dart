import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'you_and_food_bloc.freezed.dart';

part 'you_and_food_event.dart';

part 'you_and_food_state.dart';

@singleton
class YouAndFoodBloc extends Bloc<YouAndFoodEvent, YouAndFoodState> {
  YouAndFoodBloc() : super(YouAndFoodState.initial());
}
