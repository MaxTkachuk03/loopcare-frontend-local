import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/home/application/navigation_bar_bloc.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/features/river/domain/feature_placement.dart';
import 'package:loopcare_frontend/features/river/domain/river_module.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/presentation/utils/module_items_utils.dart';
import 'package:loopcare_frontend/features/river/presentation/utils/river_utils.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/river_module_builder.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/river_module_item_widget/river_animation_module_item_widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

class RiverScreen extends StatefulWidget {
  const RiverScreen({
    super.key,
    required this.module,
    required this.page,
  });

  final RiverModule module;
  final int page;

  @override
  State<RiverScreen> createState() => _RiverScreenState();
}

class _RiverScreenState extends State<RiverScreen> with RiverUtils {
  late List<({Offset offset, RiverModuleItem item})> _positionedItems;
  late int _page;

  bool _isOnViewport = false;
  bool _showPopup = false;

  @override
  bool get isBeginning => _page == 0;

  @override
  void initState() {
    super.initState();
    _page = getIndex(widget.page);
    _positionedItems = ModuleItemsUtils.getAllocatedItems(_page, widget.module.moduleItems);

    final state = context.read<RiverBloc>().state;
    final activeModule = state.data.activeModule;
    if (activeModule.isModuleItemsCompleted &&
        activeModule.isInProgress &&
        activeModule?.id == state.data.modules.firstOrNull?.id) {
      _showPopup = true;
      _showCompleteDialog();
    }
  }

  @override
  void didUpdateWidget(covariant RiverScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.module.moduleItems.equals(oldWidget.module.moduleItems)) {
      _positionedItems = ModuleItemsUtils.getAllocatedItems(_page, widget.module.moduleItems);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dimension = size.width;
    final itemTopPositionOffset = (size.height - dimension) / 2.5;
    final isCompleted = widget.module.moduleState.isCompleted ||
        (isBeginning && widget.module.isModuleItemsCompleted);

    return BlocListener<RiverBloc, RiverState>(
      // todo: move to river_page.dart
      listener: (context, state) => state.mapOrNull(
        moduleCompleted: _onCompleteModule,
        modulePartlyCompleted: _onPartlyCompleteModule,
      ),
      child: VisibilityDetector(
        key: ValueKey('module_page_${widget.page}'),
        onVisibilityChanged: onViewPortChanged,
        child: RiverModuleBuilder(
          topOffset: itemTopPositionOffset,
          dimension: dimension,
          direction: Axis.horizontal,
          onCompleted: _onCompleteTime,
          index: _page,
          completedDate: widget.module.nextModuleUnlocksAt,
          totalDelay: widget.module.nextModuleUnlockDelay,
          isCompleted: isCompleted,
          title: widget.module.title,
          positionedItems: _positionedItems,
          itemBuilder: (context, item) {
            return RiverAnimationModuleItemWidget(
              item: item,
              radius: itemRadius(isRoot: item.isRootItem),
              isBeginning: isBeginning,
              onTap: () => _onItemPressed(item),
              onAnimationComplete: (placement) => _onAnimationCompleted(item, placement),
            );
          },
        ),
      ),
    );
  }

  void _onItemPressed(RiverModuleItem item) {
    if (item.states.prevItemState.isLocked) {
      _bounceParentItem(item);
    } else if (isBeginning) {
      _beginningUnlockAction(item);
    } else {
      _navigateToLesson(item);
    }
  }

  void _bounceParentItem(RiverModuleItem item) {
    context.read<RiverBloc>().add(RiverEvent.bounceParentItem(
          moduleItemId: item.id,
          moduleId: widget.module.id,
        ));
  }

  void _updateModuleItem(int id) {
    final riverBloc = context.read<RiverBloc>();

    riverBloc.add(
      RiverEvent.updateModuleItemById(
        moduleId: widget.module.id,
        moduleItemId: id,
      ),
    );
  }

  void onViewPortChanged(VisibilityInfo info) {
    _isOnViewport = info.visibleFraction > 0;
    _showCompleteDialog();
  }

  void _beginningUnlockAction(RiverModuleItem item) {
    if (item.states.prevItemState.isCompleted) {
      return;
    }

    if (item.isRootItem) {
      context.router.push(SelectAvatarRoute(onDispose: () => _updateModuleItem(item.id)));
    } else if (item.isPractice) {
      ModalBottomSheet.guidancePractice(
        context: context,
        onConfirm: () => _updateModuleItem(item.id),
      );
    } else if (item.isProfile) {
      ModalBottomSheet.guidanceProfile(
        context: context,
        onConfirm: () => _updateModuleItem(item.id),
      );
    }
  }

  void _navigateToLesson(RiverModuleItem item) {
    CustomerIoService.track(
      event: CIOEvents.educationWidget,
      attributes: {CIOAttributes.articleId: item.lessonId},
    );

    context.read<RiverBloc>().add(RiverEvent.selectModuleItem(item: item));

    context.read<EducationLessonBloc>().add(
          EducationLessonEvent.getLessonContent(lessonId: item.lessonId),
        );

    context.router.push(LessonRoute(lessonId: item.lessonId, streamType: item.streamType));
  }

  void _onAnimationCompleted(RiverModuleItem item, FeaturePlacement? placement) {
    if (placement != null) {
      _onTransitionItemCompleted(placement);
    } else {
      _onStateChanged(item);
    }
  }

  void _onTransitionItemCompleted(FeaturePlacement placement) {
    final navigationBloc = context.read<NavigationBarBloc>();
    if (isBeginning && placement.isDashboard) {
      navigationBloc.add(const NavigationBarEvent.unlockPractise());
    } else if (placement.isDashboard) {
      navigationBloc.add(const NavigationBarEvent.addPractiseNotification());
    } else if (isBeginning && !placement.isDashboard) {
      navigationBloc.add(const NavigationBarEvent.unlockProfile());
    } else {
      navigationBloc.add(const NavigationBarEvent.addProfileNotification());
    }
  }

  void _onCompleteModule(RiverState state) async {
    if (widget.module.isModuleItemsCompleted && await widget.module.isTimePassed) {
      _showPopup = true;
      _showCompleteDialog();
    }
  }

  void _onPartlyCompleteModule(RiverState state) {
    if (!(ModalRoute.of(context)?.isCurrent ?? false)) return;

    if (state.data.activeModule.isModuleItemsCompleted) {
      ModalBottomSheet.moduleGraduationCompletedItems(context: context);
    } else {
      ModalBottomSheet.moduleGraduationCompletedTime(context: context);
    }
  }

  void _onStateChanged(RiverModuleItem item) {
    context.read<RiverBloc>().add(RiverEvent.updateModuleItemById(
          moduleItemId: item.id,
          moduleId: widget.module.id,
        ));
  }

  void _onCompleteTime() {
    context.read<RiverBloc>().add(const RiverEvent.checkCompletion());
  }

  void _showCompleteDialog() {
    if (!_isOnViewport || !_showPopup) return;

    _showPopup = false;

    final riverData = context.read<RiverBloc>().state.data;
    _onComplete();

    if (isBeginning) {
      context.read<NavigationBarBloc>().add(const NavigationBarEvent.completeBeginning());

      ModalBottomSheet.guidanceCompleted(context: context);
    } else if (riverData.modules.last.id == riverData.activeModule?.id) {
      ModalBottomSheet.lastModuleCompleted(
        context: context,
        moduleTitle: riverData.activeModule?.title ?? '',
      );
    } else {
      ModalBottomSheet.moduleCompleted(
        context: context,
        currentModule: riverData.activeModule?.title ?? '',
        nextModule: riverData.nextModule?.title ?? '',
      );
    }
  }

  void _onComplete() => context.read<RiverBloc>().add(const RiverEvent.completeActiveModule());
}
