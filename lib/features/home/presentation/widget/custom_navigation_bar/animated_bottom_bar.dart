import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/text/custom_text.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/core/presentation/utils/build_context_extensions.dart';
import 'package:loopcare_frontend/features/home/presentation/widget/navigation_bar_item/navigation_bar_item_widget.dart';
import 'package:loopcare_frontend/features/home/presentation/widget/navigation_bar_item/navigation_bar_items.dart';

part 'parts/_custom_bottom_navigation_bar_item.dart';
part 'parts/_animated_row.dart';

final GlobalKey kNavigationBarItemPractice = GlobalKey();
final GlobalKey kNavigationBarItemRiver = GlobalKey();
final GlobalKey kNavigationBarItemProfile = GlobalKey();

const int _initialItemCount = 3;

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.selectedItem,
    required this.onTap,
    required this.badges,
    required this.items,
  });

  final int selectedItem;
  final void Function(int index) onTap;
  final List<NavigationBarItems> items;
  final List<NavigationBarItems> badges;

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final GlobalKey<_AnimatedRowState> _listKey = GlobalKey<_AnimatedRowState>();

  late _RowModel<NavigationBarItems> _list;
  late int _selectedItem;

  void _onItemPressed(int index) {
    widget.onTap(index);
    setState(() => _selectedItem = index);
  }

  GlobalKey _getKey(NavigationBarItems item) =>
      switch (item) {
        NavigationBarItems.practice => kNavigationBarItemPractice,
        NavigationBarItems.river => kNavigationBarItemRiver,
        NavigationBarItems.account => kNavigationBarItemProfile,
      };

  @override
  void initState() {
    super.initState();
    _list = _RowModel<NavigationBarItems>(
      listKey: _listKey,
      initialItems: widget.items,
    );
    _selectedItem = widget.selectedItem;
  }

  @override
  void didUpdateWidget(covariant CustomBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items.length > _initialItemCount) {
      for (int i = 0; i < widget.items.length; i++) {
        if (!oldWidget.items.contains(widget.items[i])) {
          _list.insert(i, widget.items[i]);
        }
      }
    } else {
      _list = _RowModel<NavigationBarItems>(
        listKey: _listKey,
        initialItems: widget.items,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = kBottomNavigationBarHeight + MediaQuery.of(context).padding.bottom;

    return Container(
      height: height,
      color: AppColors.blueRegular,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: _AnimatedRow(
        key: _listKey,
        initialItemCount: _initialItemCount,
        itemBuilder: (context, index, animation) {
          final item = NavigationBarItems.itemAtIndex(index);
          final enableItem = _list.contains(NavigationBarItems.itemAtIndex(index));

          if (enableItem) {
            final isSelected = _selectedItem == index;

            return _CustomBottomNavigationBarItem(
              animation: animation,
              icon: NavigationBarItemWidget(
                key: _getKey(item),
                item: item,
                isSelected: isSelected,
              ),
              label: item.label,
              showBadge: widget.badges.contains(item),
              selected: _selectedItem == index,
              onTap: () => _onItemPressed(index),
            );
          } else {
            return SizedBox.expand(
              key: _getKey(item),
            );
          }
        },
      ),
    );
  }
}
