import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/scale_gesture_detector/scale_gesture_detector.dart';
import 'package:loopcare_frontend/features/home/application/navigation_bar_bloc.dart';
import 'package:loopcare_frontend/features/reflections/application/reflections_bloc.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/features/river/domain/river_module.dart';
import 'package:loopcare_frontend/features/river/presentation/river_page_widgets/river_module_view.dart';
import 'package:visibility_detector/visibility_detector.dart';

@RoutePage()
class RiverPage extends StatefulWidget {
  const RiverPage({super.key});

  @override
  State<RiverPage> createState() => _RiverPageState();
}

class _RiverPageState extends State<RiverPage> {
  late PageController _controller;
  late int _page;

  bool _isOnViewport = true;

  @override
  void initState() {
    super.initState();
    _page = context.read<RiverBloc>().state.data.currentPage;
    _controller = PageController(initialPage: _page);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const ValueKey('river_module_page'),
      onVisibilityChanged: _onViewPortChanged,
      child: CustomScaffold.blueLightest(
        body: ScaleGestureDetector(
          onZoomOut: _navigationHandler,
          child: CustomSafeArea(
            child: MultiBlocListener(
              listeners: [
                BlocListener<RiverBloc, RiverState>(
                  listener: (context, state) => state.mapOrNull(
                    moduleCompleted: _onCompleteModule,
                    modulePartlyCompleted: _onPartlyCompleteModule,
                  ),
                ),
                BlocListener<RiverBloc, RiverState>(
                  listenWhen: _riverListenWhen,
                  listener: _refreshReflections,
                ),
              ],
              child: BlocBuilder<RiverBloc, RiverState>(
                builder: (context, state) {
                  return state.maybeMap(
                    moduleLoadingError: (state) => ErrorScreen(error: state.data.error!),
                    orElse: () => PageView.builder(
                      onPageChanged: _onPageChanged,
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
        ),
      ),
    );
  }

  Future<void> _navigationHandler() => context.router.pushNamed(AppRoutes.riverOverview);

  void _refreshReflections(BuildContext context, RiverState state) =>
      context.read<ReflectionsBloc>().add(const ReflectionsEvent.getReflections());

  bool _riverListenWhen(RiverState previous, RiverState current) =>
      previous is RiverStateModuleItemLoading &&
      (current is RiverStateModuleItemLoaded || current is RiverStateModuleLoaded) &&
      previous.data.activeModuleItem != null &&
      previous.data.activeModuleItem?.unlocksReflectionId != null &&
      current.data.activeModuleItem == null &&
      (previous.data.activeModuleItem?.states.prevItemState.isUnLocked ?? false);

  void _onPageChanged(int page) {
    if (_page < page) {
      _checkCompletion(page);
    }

    _page = page;
  }

  void _onViewPortChanged(VisibilityInfo info) {
    final isOnViewport = info.visibleFraction > 0;
    if (_isOnViewport != isOnViewport && isOnViewport) {
      _isOnViewport = isOnViewport;
      _checkCompletion();
    }
  }

  void _onPartlyCompleteModule(RiverState state) {
    if (!_isOnViewport) return;

    if (state.data.activeModule.isModuleItemsCompleted) {
      ModalBottomSheet.moduleGraduationCompletedItems(context: context);
    } else {
      ModalBottomSheet.moduleGraduationCompletedTime(context: context);
    }
  }

  void _onCompleteModule(RiverState state) => _showCompleteDialog();

  void _showCompleteDialog() {
    if (!_isOnViewport) return;

    final riverData = context.read<RiverBloc>().state.data;
    final completedModule = riverData.lastCompletedModule;

    if (riverData.modules.first.id == completedModule?.id) {
      context.read<NavigationBarBloc>().add(const NavigationBarEvent.completeBeginning());

      ModalBottomSheet.guidanceCompleted(context: context);
    } else if (riverData.modules.last.id == completedModule?.id) {
      ModalBottomSheet.lastModuleCompleted(
        context: context,
        moduleTitle: completedModule?.title ?? '',
      );
    } else {
      ModalBottomSheet.moduleCompleted(
        context: context,
        currentModule: completedModule?.title ?? '',
        nextModule: riverData.activeModule?.title ?? '',
      );
    }
  }

  void _checkCompletion([int? page]) =>
      context.read<RiverBloc>().add(RiverEvent.checkCompletion(page: page));
}
