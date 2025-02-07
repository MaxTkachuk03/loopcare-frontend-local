import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/custom_app_icon/custom_app_icon.dart';
import 'package:loopcare_frontend/core/presentation/error/error_screen.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/loader/loader.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/pool_status/application/pool_bloc/pool_module_bloc.dart';
import 'package:loopcare_frontend/features/reflections/application/reflections_bloc.dart';
import 'package:loopcare_frontend/features/reflections/presentation/new_design/widgets/reflections_dashboard_list.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

import '../../domain/reflection.dart';

class ReflectionsDashboard extends StatefulWidget {
  final bool unlocked;
  final List<Reflection> currentReflections;
  final bool hasReflection;

  const ReflectionsDashboard({
    super.key,
    required this.unlocked,
    required this.currentReflections,
    required this.hasReflection,
  });

  @override
  State<ReflectionsDashboard> createState() => _ReflectionsDashboardState();
}

class _ReflectionsDashboardState extends State<ReflectionsDashboard> {
  bool onClick = false;

  void toggleOnClick() {
    setState(() {
      onClick = !onClick;
    });
  }

  void _onErrorHandler(BuildContext context) =>
      context.read<ReflectionsBloc>().add(const ReflectionsEvent.getReflections());

  void getPoolData(e) => context.read<PoolModuleBloc>().add(const PoolModuleEvent.getPoolData());

  void _onItemPressedHandler(BuildContext context, Reflection item, bool fromDashboard) =>
      context.router
          .push(ReflectionsIntroRoute(reflectionItem: item, fromDashboard: fromDashboard));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardCardTitle(
              onTap: () => widget.unlocked
                  ? context.router.push(const ReflectionsRoute()).then(getPoolData)
                  : toggleOnClick(),
              highlightColor: widget.unlocked ? AppColors.petrolLightest : AppColors.white,
              leadingIcon: widget.unlocked
                  ? const CustomAppIcon.reflection()
                  : const CustomAppIcon.reflectionGrey(),
              title: widget.unlocked
                  ? CustomText.bitter600(
                      LocalizedTexts.reflection.tr(),
                      style: context.textTheme.headlineSmall,
                    )
                  : CustomText.bitter400(
                      LocalizedTexts.reflection.tr(),
                      style: const TextStyle(color: AppColors.greyLight, fontSize: 20),
                    ),
              actionIcon: widget.unlocked
                  ? AppIcons.arrow
                  : onClick
                      ? const AssetImage(AppIcons.upArrow)
                      : AppIcons.downArrow,
              circleButton: widget.unlocked ? true : false,
            ),
            widget.unlocked && widget.hasReflection
                ? const Divider(color: AppColors.blueLighter, indent: 8.0, endIndent: 8.0)
                : const SizedBox(),
            widget.unlocked
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        AppIcons.lockGoals,
                        const SizedBox(
                          width: 36,
                        ),
                        Expanded(
                          child: CustomText.w400(
                            "${LocalizedTexts.featureUnlocksAtPool.tr()} ${LocalizedTexts.reflectionsUnlock.tr()}",
                            style: const TextStyle(color: AppColors.greyLight, fontSize: 16),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                  ),
            onClick && !widget.unlocked
                ? Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomText.w400(
                            maxLines: 10,
                            LocalizedTexts.reflectionsDescription.tr(),
                            overflow: TextOverflow.visible,
                            style: const TextStyle(color: AppColors.greyLight, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            widget.unlocked
                ? BlocBuilder<ReflectionsBloc, ReflectionsState>(
                    builder: (context, state) {
                      return state.maybeMap(
                        loading: (_) => const SizedBox(height: 100, child: Loader()),
                        error: (errorState) {
                          final error = errorState.data.error;

                          return ErrorScreen(
                            error: error!,
                            onButtonPressed: () => _onErrorHandler(context),
                          );
                        },
                        orElse: () => Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 18),
                            child: widget.currentReflections.isNotEmpty
                                ? Column(
                                    children: [
                                      if (widget.currentReflections.isNotEmpty)
                                        ListView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: widget.currentReflections.length,
                                          itemBuilder: (BuildContext context, int i) {
                                            final item = widget.currentReflections[i];
                                            final itemStatus = state.data
                                                .getReflectionStatus(i, widget.currentReflections);
                                            return ReflectionsDashboardListItem(
                                                item: item,
                                                itemStatus: itemStatus,
                                                onItemPressedHandler: _onItemPressedHandler);
                                          },
                                        ),
                                    ],
                                  )
                                : const SizedBox()),
                      );
                    },
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
