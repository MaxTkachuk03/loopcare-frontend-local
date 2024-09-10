import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/presentation/widgets/overlay_popup/overlay_service_mode.dart';
import 'package:loopcare_frontend/core/presentation/widgets/overlay_popup/popover_card_sheet.dart';
import 'package:rxdart/subjects.dart';

part 'overlay_service.freezed.dart';

@freezed
class OverlayEvent with _$OverlayEvent {
  const OverlayEvent._();

  // Dialogs
  const factory OverlayEvent.chatPopCard({
    required BuildContext context,
    required OverlayServiceMode mode,
    bool? needOffset,
  }) = _ChatPopCard;
}

@singleton
class OverlayService {
  final _behaviorSubject = BehaviorSubject<OverlayEvent>();

  BuildContext get _context => kOverlayContext;

  OverlayService() {
    init();
  }

  void init() {
    _behaviorSubject.listen(
      (event) {
        event.when(
            chatPopCard: (BuildContext context, OverlayServiceMode mode, needOffset) =>
                PopoverCardSheet.showMenuPopup(context, mode,
                    withSeparator: true, needOffset: needOffset));
      },
    );
  }

  void close() {
    if (Navigator.of(_context).canPop()) {
      Navigator.of(_context).pop();
    }
  }

  void show(OverlayEvent overlayEvent) => _behaviorSubject.add(overlayEvent);
}
