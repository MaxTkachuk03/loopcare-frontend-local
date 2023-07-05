import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/nutrition/domain/dashboard/dashboard_navbar_items.dart';

part 'home_bottom_navigation_bloc.freezed.dart';

part 'home_bottom_navigation_event.dart';

part 'home_bottom_navigation_state.dart';

@injectable
class HomeBottomNavigationBloc extends Bloc<HomeBottomNavigationEvent, HomeBottomNavigationState> {
  HomeBottomNavigationBloc() : super(HomeBottomNavigationState.initial()) {
    on<TabChanged>(_onTabChanged);
  }

  void _onTabChanged(
    TabChanged event,
    Emitter<HomeBottomNavigationState> emit,
  ) {
    emit(state.copyWith(activeTab: event.tab));
  }
}
