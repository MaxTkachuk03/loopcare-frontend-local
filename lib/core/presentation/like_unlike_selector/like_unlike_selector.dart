import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/localization/localized_texts.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class LikeUnlikeSelector extends StatefulWidget {
  final Function(bool val) onChange;
  final bool value;

  const LikeUnlikeSelector({super.key, required this.onChange, required this.value});

  @override
  State<LikeUnlikeSelector> createState() => _LikeUnlikeSelectorState();
}

class _LikeUnlikeSelectorState extends State<LikeUnlikeSelector> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: widget.value ? 1 : 0,
    );
  }

  void _onTabChangeHandler(int index) => widget.onChange(index == 0 ? false : true);

  get _labelStyles => const TextStyle(color: AppColors.blueDarker, fontSize: 12, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 138,
      height: 76,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 130,
            height: 68,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 2, color: AppColors.blueDarker),
            ),
          ),
          TabBar(
            onTap: _onTabChangeHandler,
            controller: _tabController,
            indicatorColor: AppColors.greenRegular,
            dividerColor: AppColors.transparent,
            dividerHeight: 0,
            labelColor: AppColors.blueDarker,
            labelStyle: _labelStyles,
            unselectedLabelStyle: _labelStyles,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.greenRegular,
            ),
            splashBorderRadius: BorderRadius.circular(8),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                text: LocalizedTexts.notReally.tr(),
                icon: Icon(!widget.value ? Icons.thumb_down_alt_rounded : Icons.thumb_down_alt_outlined),
              ),
              Tab(
                text: LocalizedTexts.yesYes.tr(),
                icon: Icon(widget.value ? Icons.thumb_up_alt_rounded : Icons.thumb_up_alt_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
