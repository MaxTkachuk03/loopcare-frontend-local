import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/get_measurement_system.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/measurement_system.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/measurement_system_type.dart';

class UnitTabs extends StatefulWidget {
  final List<Widget> tabBarViewChildren;
  final Function(MeasurementSystemType unitType) onTabChanged;

  const UnitTabs({
    Key? key,
    required this.tabBarViewChildren,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  State<UnitTabs> createState() => _UnitTabsState();
}

class _UnitTabsState extends State<UnitTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<MeasurementSystem> tabs = [
    MeasurementSystem(
      text: LocalizedTexts.metric.tr(),
      type: MeasurementSystemType.metric,
    ),
    MeasurementSystem(
      text: LocalizedTexts.imperial.tr(),
      type: MeasurementSystemType.imperial,
    ),
  ];

  @override
  void initState() {
    final currentMeasurementSystem = getMeasurementSystem();

    _tabController = TabController(
      vsync: this,
      length: tabs.length,
      animationDuration: Duration.zero,
      initialIndex:
          currentMeasurementSystem == MeasurementSystemType.imperial ? 1 : 0,
    );

    _tabController.addListener(_onTabChanged);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 84,
            child: TabBarView(
              controller: _tabController,
              children: widget.tabBarViewChildren,
            )),
        const SizedBox(
          height: 26.0,
        ),
        Container(
          width: 240.0,
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
              color: AppColors.yellowLight,
              borderRadius: BorderRadius.circular(8.0)),
          child: TabBar(
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e.text)).toList(),
          ),
        ),
      ],
    );
  }

  void _onTabChanged() {
    widget.onTabChanged(tabs[_tabController.index].type);
  }
}
