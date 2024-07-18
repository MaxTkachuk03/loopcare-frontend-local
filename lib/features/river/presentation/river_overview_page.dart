import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/scale_gesture_detector/scale_gesture_detector.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';
import 'package:loopcare_frontend/features/river/presentation/widgets/river_module_preview.dart';
import 'package:loopcare_frontend/injection.dart';

@RoutePage()
class RiverOverviewPage extends StatefulWidget {
  const RiverOverviewPage({super.key});

  @override
  State<RiverOverviewPage> createState() => _RiverOverviewPageState();
}

class _RiverOverviewPageState extends State<RiverOverviewPage> {
  Future<void> _navigationHandler() async {
    if (context.router.canPop()) {
      context.router.maybePop();
    } else {
      context.router.replaceNamed(AppRoutes.home);
    }
  }

  @override
  void initState() {
    super.initState();
    getIt<SharedStorageService>().riverOverviewVisited();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).removePadding(removeBottom: true),
      child: CustomScaffold.blueLightest(
        body: ScaleGestureDetector(
          onTap: _navigationHandler,
          onZoomIn: _navigationHandler,
          child: BlocBuilder<RiverBloc, RiverState>(
            builder: (context, state) {
              return ListView.builder(
                itemCount: state.data.modules.length + 1,
                itemBuilder: (context, index) => index == 0
                    ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: CustomText.bitter600(
                          LocalizedTexts.riverOverviewTitle.tr(),
                          style: context.textTheme.displayLarge,
                          textAlign: TextAlign.center,
                        ),
                    )
                    : RiverModulePreview(module: state.data.modules[index - 1], page: index - 1),
              );
            },
          ),
        ),
      ),
    );
  }
}
