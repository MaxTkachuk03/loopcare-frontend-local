import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/buttons/custom_elevated_button.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/dashboard_card_title/dashboard_card_title.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/pool_status/application/pool_bloc/pool_module_bloc.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';

class DashboardMindWidget extends StatefulWidget {
  final bool locked;
  const DashboardMindWidget({super.key, required this.locked});

  @override
  State<DashboardMindWidget> createState() => _DashboardMindWidgetState();
}

class _DashboardMindWidgetState extends State<DashboardMindWidget> {
  bool onClick = false;

  void toggleOnClick() {
    setState(() {
      onClick = !onClick;
    });
  }

  void onPressHandler(BuildContext context) =>
      context.router.pushNamed(AppRoutes.mindTechniques).then(getPoolData);

  void getPoolData(e) => context.read<PoolModuleBloc>().add(const PoolModuleEvent.getPoolData());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 8.0),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardCardTitle(
            onTap: () {
              if (widget.locked) {
              } else {
                toggleOnClick();
              }
            },
            highlightColor: widget.locked ? AppColors.petrolLightest : AppColors.white,
            leadingIcon:
                widget.locked ? AppIcons.customDashboardMind : AppIcons.customDashboardMindGrey,
            title: widget.locked
                ? CustomText.bitter600(
                    LocalizedTexts.mindDashboardTitle.tr(),
                    style: context.textTheme.headlineSmall,
                  )
                : CustomText.bitter400(
                    LocalizedTexts.mindDashboardTitle.tr(),
                    style: const TextStyle(color: AppColors.greyLight, fontSize: 20),
                  ),
            editable: true,
            actionIcon: onClick ? const AssetImage(AppIcons.upArrow) : AppIcons.downArrow,
            circleButton: widget.locked ? true : false,
          ),
          widget.locked
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                  child: CustomElevatedButton.petrolSmall(
                    label: LocalizedTexts.mindDashboardBtn.tr(),
                    onPressed: () => onPressHandler(context),
                  ),
                )
              : const SizedBox(),
          widget.locked
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      AppIcons.lockGoals,
                      const SizedBox(
                        width: 36,
                      ),
                      SizedBox(
                        width: 250,
                        child: Text(
                          "${LocalizedTexts.featureUnlocksAtPool.tr()} ${LocalizedTexts.mindTraining.tr()}",
                          style: const TextStyle(color: AppColors.greyLight, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
          onClick && !widget.locked
              ? Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 350,
                        child: CustomText.w400(
                          maxLines: 10,
                          LocalizedTexts.mindTrainingLockedDescription.tr(),
                          style: const TextStyle(color: AppColors.greyLight, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
