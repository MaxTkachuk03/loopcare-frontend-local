import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/features/mental_health/application/mental_health_bloc.dart';

class MentalHealthWrap extends StatelessWidget {
  final Widget child;
  final bool? withoutPagination;

  const MentalHealthWrap({super.key, required this.child, this.withoutPagination});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: child,
    );
  }

  Future<bool> _onWillPop(BuildContext context) {
    context.read<MentalHealthBloc>().add(const MentalHealthEvent.prevPage());

    return Future.value(true);
  }
}
