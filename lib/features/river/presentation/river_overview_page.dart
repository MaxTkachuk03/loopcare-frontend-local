import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/custom_safe_area.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_images.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/scaffold/custom_scaffold.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/river/application/river_bloc.dart';

const _titles = [
  "The \nBeginning",
  "What’s \nyour why?",
  "Don’t go \nit alone",
  "Digging \ndeeper",
  "Eating \nHabits",
  "Back to basics",
  "Let’s talk \nabout \nstress",
  "Know \nyour limits",
];

// TODO screen will be totally changed with custom painter
@RoutePage()
class RiverOverviewPage extends StatefulWidget {
  const RiverOverviewPage({super.key});

  @override
  State<RiverOverviewPage> createState() => _RiverOverviewPageState();
}

class _RiverOverviewPageState extends State<RiverOverviewPage> {
  @override
  void initState() {
    super.initState();
    context.read<RiverBloc>().add(const RiverEvent.getModules());
  }

  _onGestureHandler(BuildContext context) => context.router.pushNamed(AppRoutes.home);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.blueLightest(
      body: CustomSafeArea(
        child: GestureDetector(
          onTap: () => _onGestureHandler(context),
          onScaleUpdate: (_) => _onGestureHandler(context),
          child: ScrollableContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 60.0,
                ),
                CustomText.bitter600(
                  LocalizedTexts.riverOverviewTitle.tr(),
                  style: context.textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ..._titles.map(
                          (t) => Container(
                            height: 241,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0x00ECF5FF).withOpacity(1),
                                  const Color(0x00c6ddf6).withOpacity(0.8),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0, right: 20),
                              child: CustomText.bitter600(
                                t,
                                style: context.textTheme.bodyLarge,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Image(image: AppImages.riverOverviewMockPng),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
