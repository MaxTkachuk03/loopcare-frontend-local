import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/scale_gesture_detector/scale_gesture_detector.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/river_module_view.dart';

@RoutePage()
class RiverPage extends StatefulWidget {
  const RiverPage({super.key});

  @override
  State<RiverPage> createState() => _RiverPageState();
}

class _RiverPageState extends State<RiverPage> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: context.read<RiverBloc>().state.data.currentPage,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _navigationHandler() => context.router.pushNamed(AppRoutes.riverOverview);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blueLightest(
      body: ScaleGestureDetector(
        onZoomOut: _navigationHandler,
        child: CustomSafeArea(
          child: BlocConsumer<RiverBloc, RiverState>(
            listener: (context, state) {
              state.mapOrNull(
                moduleItemLoaded: (_) => context.read<RiverBloc>().add(const RiverEvent.checkCompletion())
              );
            },
            builder: (context, state) {
              return state.maybeMap(
                moduleLoadingError: (state) => ErrorScreen(error: state.data.error!),
                orElse: () => PageView.builder(
                  controller: _controller,
                  itemCount: state.data.modules.length,
                  itemBuilder: (context, index) => RiverScreen(
                    module: state.data.modules[index],
                    page: index,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
