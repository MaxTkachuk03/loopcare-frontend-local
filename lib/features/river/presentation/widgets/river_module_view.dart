import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_service.dart';
import 'package:loopcare_frontend/core/presentation/alerting/modal_bottom_sheet.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/education/application/education_lesson/education_lesson_bloc.dart';
import 'package:loopcare_frontend/features/home/application/navigation_bar_bloc.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/features/river/domain/river_module.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_item.dart';
import 'package:loopcare_frontend/features/river/infrastructure/feature_placement.dart';
import 'package:loopcare_frontend/features/river/presentation/river_module_item_widget/river_animation_module_item_widget.dart';
import 'package:loopcare_frontend/features/river/presentation/utils/module_items_utils.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/animated_river_streams.dart';

const double _startButtonRadius = 36.0;

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

class _RiverScreenState extends State<RiverScreen> {
  late List<({Offset offset, RiverModuleItem item})> _positionedItems;
  late int _page;

  bool get _isTheBeginningModule => _page == 0;

  @override
  void initState() {
    super.initState();
    _page = _getIndex(widget.page);
    _positionedItems = ModuleItemsUtils.getItemsOffsets(_page, widget.module.moduleItems);
  }

  @override
  void didUpdateWidget(covariant RiverScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.module.moduleItems.equals(oldWidget.module.moduleItems)) {
      _positionedItems = ModuleItemsUtils.getItemsOffsets(_page, widget.module.moduleItems);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dimension = size.width;
    final itemTopPositionOffset = (size.height - dimension) / 2.5;

    final positionedModuleItems = List.generate(
      _positionedItems.length,
      (index) {
        final offset = _positionedItems[index].offset;
        final item = _positionedItems[index].item;
        final radius = item.isRootItem ? 36.0 : 25.0;
        return Positioned(
          left: dimension * offset.dx - radius,
          top: itemTopPositionOffset + dimension * offset.dy - radius,
          child: RiverAnimationModuleItemWidget(
            item: item,
            radius: radius,
            isBeginning: _isTheBeginningModule,
            onTap: () => _onItemPressed(item),
            onTransitionComplete: _onTransitionItemCompleted,
          ),
        );
      },
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 20.0,
          child: CustomText.bitter600(
            widget.module.title,
            style: context.textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          top: itemTopPositionOffset,
          height: dimension,
          width: dimension,
          child: AnimatedRiverStreams(
            page: _page,
            completedDate: widget.module.nextModuleUnlocksAt,
            totalDelay: widget.module.nextModuleUnlockDelay,
            isCompleted: widget.module.isCompleted,
            onCompleted: _onCompleteTime,
          ),
        ),
        if (_isTheBeginningModule)
          Positioned(
            top: itemTopPositionOffset +
                dimension * ModuleItemsUtils.startButtonPosition.dy -
                _startButtonRadius,
            left: dimension * ModuleItemsUtils.startButtonPosition.dx - _startButtonRadius,
            child: CircleAvatar(
              radius: _startButtonRadius,
              backgroundColor: AppColors.blueRegular,
              child: CustomText.w400(
                LocalizedTexts.start.tr(),
                style: context.textTheme.bodyLarge?.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ...positionedModuleItems,
      ],
    );
  }

  int _getIndex(int i) => i <= 5 ? i : _getIndex(i - 5);

  void _onItemPressed(RiverModuleItem item) {
    if (_isTheBeginningModule) {
      _beginningUnlockAction(item);
    } else {
      _navigateToLesson(item);
    }
  }

  void _beginningUnlockAction(RiverModuleItem item) {
    if (item.itemState.isCompleted) {
      return;
    }

    final riverBloc = context.read<RiverBloc>();

    if (item.isPractice) {
      ModalBottomSheet.guidancePractice(
        context: context,
        onConfirm: () => riverBloc.add(
          RiverEvent.updateModuleItem(
            moduleId: widget.module.id,
            moduleItemId: item.id,
          ),
        ),
      );
    }

    if (item.isProfile) {
      ModalBottomSheet.guidanceProfile(
        context: context,
        onConfirm: () => riverBloc.add(
          RiverEvent.updateModuleItem(
            moduleId: widget.module.id,
            moduleItemId: item.id,
          ),
        ),
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

  void _onTransitionItemCompleted(FeaturePlacement placement) {
    final navigationBloc = context.read<NavigationBarBloc>();
    if (_isTheBeginningModule && placement.isDashboard) {
      navigationBloc.add(const NavigationBarEvent.unlockPractise());
    } else if (placement.isDashboard) {
      navigationBloc.add(const NavigationBarEvent.addPractiseNotification());
    } else if (_isTheBeginningModule && !placement.isDashboard) {
      navigationBloc.add(const NavigationBarEvent.unlockProfile());
    } else {
      navigationBloc.add(const NavigationBarEvent.addProfileNotification());
    }
  }

  void _onCompleteTime() {
    if (_isTheBeginningModule &&
        !context.read<NavigationBarBloc>().state.data.isBeginningCompleted) {
      ModalBottomSheet.guidanceCompleted(
        context: context,
        onConfirm: () =>
            context.read<NavigationBarBloc>().add(const NavigationBarEvent.completeBeginning()),
      );
    } else {
      _onComplete();
    }
  }

  void _onComplete() => context.read<RiverBloc>().add(const RiverEvent.checkCompletion());
}
