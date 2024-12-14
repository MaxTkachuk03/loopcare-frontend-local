import 'package:flutter/foundation.dart';
import 'package:loopcare_frontend/core/domain/physical_activities_type.dart';
import 'package:loopcare_frontend/features/physical_activities/application/physical_activities_preferences/physical_activities_preferences_bloc.dart';

class PhysicalActivitiesTypeController {
  late ValueNotifier<PhysicalActivitiesType?> _tabListener;
  final int length;
  final PhysicalActivitiesPreferencesBloc bloc;

  PhysicalActivitiesTypeController({
    required this.length,
    required this.bloc,
  }) {
    _tabListener = ValueNotifier(null);
    if (bloc.state.data.isTargetsSet) {
      set(bloc.state.data.trainingTargets);
    }
  }

  ValueListenable<PhysicalActivitiesType?> get listener => _tabListener;

  int? get selection {
    if (_tabListener.value == null) {
      return null;
    }
    return _tabListener.value!.index;
  }

  set(PhysicalActivitiesType? value) => _tabListener.value = value;

  void jumpToTab(int index) {
    _tabListener.value = PhysicalActivitiesType.values[index];
    if (_tabListener.value == null) {
      return;
    }
    bloc.add(PhysicalActivitiesPreferencesEvent.setTargets(_tabListener.value!));
  }

  void dispose() {
    _tabListener.dispose();
  }
}
