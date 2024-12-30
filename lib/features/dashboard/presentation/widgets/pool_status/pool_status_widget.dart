import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loopcare_frontend/core/presentation/icon_images/app_icons.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/dashboard/presentation/widgets/pool_status/widget/custom_tile.dart';
import 'package:loopcare_frontend/features/river/domain/river_module_stream_type.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';
import 'package:loopcare_frontend/localization/service/Localized_texts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'application/domain/module_item.dart';
import 'application/pool_bloc/pool_module_bloc.dart';
import 'widget/wave_widget.dart';

class PoolStatusWidget extends StatefulWidget with RouteAware {
  const PoolStatusWidget({super.key});

  @override
  State<PoolStatusWidget> createState() => _PoolStatusWidgetState();
}

class _PoolStatusWidgetState extends State<PoolStatusWidget> {
  double progress = 0.0;
  late SharedPreferences prefs;
  double initialProgress = 0.0;
  DateTime? initialVisitDate;
  int daysSpent = 0;
  int daysLeft = 0;
  String? savedTitle;
  final int totalDays = 7;

  @override
  void initState() {
    super.initState();
    _loadVisitDate();

    context.read<PoolModuleBloc>().add(const PoolModuleEvent.getPoolData());
  }

  void onPressHandler() => context.router.pushNamed(AppRoutes.groupPreferences);

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat("MMMM d, h:mm a").format(dateTime);
    formattedDate = addOrdinalSuffix(formattedDate, dateTime.day);
    return formattedDate;
  }

  String addOrdinalSuffix(String formattedDate, int day) {
    String suffix;
    if (day >= 11 && day <= 13) {
      suffix = 'th';
    } else {
      switch (day % 10) {
        case 1:
          suffix = 'st';
          break;
        case 2:
          suffix = 'nd';
          break;
        case 3:
          suffix = 'rd';
          break;
        default:
          suffix = 'th';
          break;
      }
    }
    return formattedDate.replaceFirst(RegExp(r'\d+'), '$day$suffix');
  }

  void _loadVisitDate() async {
    prefs = await SharedPreferences.getInstance();

    final initialDateString = prefs.getString('initialVisitDate');
    savedTitle = prefs.getString('savedTitle');

    if (initialDateString != null && savedTitle != null) {
      initialVisitDate = DateTime.parse(initialDateString);

      getPool();
      _updateTimer();
    } else {
      initialVisitDate = DateTime.now();
      await prefs.setString(
          'initialVisitDate', initialVisitDate!.toIso8601String());

      _updateTimer();
    }
  }

  void getPool() {
    context.read<PoolModuleBloc>().add(const PoolModuleEvent.getPoolData());
  }

  void _updateTimer() {
    final now = DateTime.now();
    final difference = now.difference(initialVisitDate!);
    int totalDays = context.read<PoolModuleBloc>().state.when(
          initial: () => 7,
          loading: () => 7,
          loaded: (moduleItem) => (moduleItem.nextModuleUnlockDelay! ~/ 86400),
          error: (error) => 7,
        );

    setState(() {
      String currentTitle = context.read<PoolModuleBloc>().state.when(
            initial: () => '',
            loading: () => '',
            loaded: (moduleItem) => moduleItem.title.toString(),
            error: (error) => '',
          );

      if (savedTitle != currentTitle) {
        savedTitle = currentTitle;
        prefs.setString('savedTitle', savedTitle!);
        initialVisitDate = DateTime.now();
        prefs.setString(
            'initialVisitDate', initialVisitDate!.toIso8601String());
      }
      daysSpent = difference.inDays + 1;
      daysLeft = totalDays - daysSpent;

      initialProgress = initialProgress + (daysSpent / totalDays);
      double newProgress = initialProgress;
      newProgress = newProgress.clamp(0.0, 1.0);

      setState(() {
        progress = newProgress;
      });

      prefs.setDouble('progress', progress);

      if (progress >= 1.0) {}

      if (daysLeft < 0) {
        daysLeft = 0;
      }
    });
  }

  String getIconPathForModule(ModuleItem module) {
    String iconPath;

    print("${module.iconType.toString()}:  ${module.states?.itemState}");

    switch (module.iconType.toString()) {
      case 'reflection':
        iconPath = module.states?.itemState == 'completed'
            ? AppIcons.tick
            : (module.states?.itemState == 'unlocked' ||
                    module.states?.itemState == 'read'
                ? AppIcons.reflectionUnlocked
                : AppIcons.account);
        break;
      case 'nutrition':
        iconPath = module.states?.itemState == 'completed'
            ? AppIcons.tick
            : (module.states?.itemState == 'unlocked' ||
                    module.states?.itemState == 'read'
                ? AppIcons.foodUnlocked
                : AppIcons.spoons);
        break;
      case 'education':
        iconPath = module.states?.itemState == 'completed'
            ? AppIcons.tick
            : (module.states?.itemState == 'unlocked' ||
                    module.states?.itemState == 'read'
                ? AppIcons.educationUnlocked
                : AppIcons.educationLocked);
        break;
      case 'goal':
        iconPath = module.states?.itemState == 'completed'
            ? AppIcons.tick
            : (module.states?.itemState == 'unlocked' ||
                    module.states?.itemState == 'read'
                ? AppIcons.goalUnlocked
                : AppIcons.goalLocked);
        break;
      case 'weight':
        iconPath = module.states?.itemState == 'completed'
            ? AppIcons.tick
            : (module.states?.itemState == 'unlocked' ||
                    module.states?.itemState == 'read'
                ? AppIcons.weightUnlocked
                : AppIcons.vector);
        break;
      case 'commitment':
        iconPath = module.states?.itemState == 'completed'
            ? AppIcons.tick
            : (module.states?.itemState == 'unlocked' ||
                    module.states?.itemState == 'read'
                ? AppIcons.commitmentUnlocked
                : AppIcons.feature);
        break;
      case 'mood':
        iconPath = module.states?.itemState == 'completed'
            ? AppIcons.tick
            : (module.states?.itemState == 'unlocked' ||
                    module.states?.itemState == 'read'
                ? AppIcons.moodMeterUnlocked
                : AppIcons.moodMeterLocked);
        break;
      default:
        iconPath = AppIcons.tick;
        break;
    }

    return iconPath;
  }

  String getLocalTime(String nextModuleUnlocksAt) {
    final date = DateTime.parse(nextModuleUnlocksAt);
    return formatDate(date.toLocal().toString());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvokedWithResult: (e, _) => _onWillPop(context),
        child: BlocBuilder<PoolModuleBloc, PoolModuleState>(
            builder: (BuildContext context, state) {
          return state.when(initial: () {
            return Container();
          }, loading: () {
            return Container();
          }, loaded: (moduleItem) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    moduleItem.title.toString(),
                    style: const TextStyle(
                        fontFamily: ThemeConstants.bitterFontFamily,
                        fontSize: 18,
                        color: AppColors.blueRegular,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTile(
                    text: moduleItem.nextModuleUnlocksAt == null
                        ? "${LocalizedTexts.tapReflection.tr()} $totalDays timer."
                        : "${LocalizedTexts.timeReq.tr()} ${moduleItem.nextModuleUnlocksAt != null ? getLocalTime(moduleItem.nextModuleUnlocksAt!) : ''}",
                    color: AppColors.blueDarker,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    image: Image.asset(
                      AppIcons.timer,
                      scale: 4,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: SizedBox(
                        height: 30,
                        width: 280,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: WavyProgressContainer(progress: progress),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: AppColors.black,
                    indent: 8.0,
                    endIndent: 8.0,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: moduleItem.moduleItems!
                        .where((module) =>
                            module.actions != null &&
                            module.actions!.any(
                                (action) => action.actionType == 'required'))
                        .length,
                    itemBuilder: (context, index) {
                      final filteredModules = moduleItem.moduleItems!
                          .where((module) =>
                              module.actions != null &&
                              module.actions!.any(
                                  (action) => action.actionType == 'required'))
                          .toList();
                      final module = filteredModules[index];
                      String text = module.widgetStatus!.text.toString();
                      String iconPath = getIconPathForModule(module);
                      return CustomTile(
                        key: ValueKey("_${module.id}_"),
                        text: text,
                        color: AppColors.blueDarker,
                        fontSize: 15,
                        image: (iconPath == AppIcons.educationUnlocked ||
                                iconPath == AppIcons.educationLocked)
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 6),
                                child: Image.asset(
                                  iconPath,
                                  height: 28,
                                  width: 28,
                                ),
                              )
                            : Image.asset(
                                iconPath,
                                color: module.states?.itemState == 'completed'
                                    ? AppColors.blueRegular
                                    : module.states?.itemState == 'unlocked' ||
                                            module.states?.itemState == 'read'
                                        ? RiverModuleStreamType
                                                .getLessonStreamType(
                                                    module.streamType!)
                                            .regularColor
                                        : AppColors.greyLighter,
                                height: 36,
                                width: 36,
                              ),
                      );
                    },
                  )
                ],
              ),
            );
          }, error: (error) {
            return Text("Error ${error.toString()}");
          });
        }));
  }

  Future<bool> _onWillPop(BuildContext context) {
    context.read<PoolModuleBloc>().add(const PoolModuleEvent.getPoolData());

    return Future.value(true);
  }
}
