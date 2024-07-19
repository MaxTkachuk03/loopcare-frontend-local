import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/presentation/custom_error_widget/error_invoker_service.dart';
import 'package:loopcare_frontend/injection.dart';

class ErrorInvoker extends StatefulWidget {
  const ErrorInvoker({
    super.key,
    required this.child,
    this.throwWhen,
  });

  final Widget child;
  final bool Function(ErrorServiceEvent event)? throwWhen;

  @override
  State<ErrorInvoker> createState() => _ErrorInvokerState();
}

class _ErrorInvokerState extends State<ErrorInvoker> {
  ErrorServiceEvent? _event;

  late final StreamSubscription<ErrorServiceEvent> _subscription;

  bool Function(ErrorServiceEvent event) get _throwWhen => widget.throwWhen ?? _defaultThrowCondition;

  bool _defaultThrowCondition(ErrorServiceEvent event) =>
      (ModalRoute.of(context)?.isCurrent ?? false) && !kIsProd;

  void _onData(ErrorServiceEvent event) {
    if (_throwWhen(event)) {
      setState(() => _event = event);
    } else {
      _event = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _subscription = getIt<ErrorInvokeService>().steam.listen(
      _onData,
    );
  }

  @override
  void dispose() {
    getIt<ErrorInvokeService>().clean();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return switch(_event) {
      ThrowArtificialError() => throw FlutterError('Artificial error'),
      _ => widget.child,
    };
  }
}

class ErrorInvokeButton extends StatelessWidget {
  const ErrorInvokeButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsDev) {
      return IconButton(
        onPressed: getIt<ErrorInvokeService>().throwArtificialError,
        icon: const Icon(
          Icons.bug_report_outlined,
          color: Colors.red,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
