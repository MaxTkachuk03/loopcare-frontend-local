import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_list/empty_list.dart';
import 'package:loopcare_frontend/core/presentation/widgets/app_list/pagination_list.dart';

class AppList<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget? emptyHolder;
  final bool isLoading;
  final bool addBottomPadding;
  final String? holderText;
  final Function() onRefresh;
  final VoidCallback? onLoadMore;
  final Axis scrollDirection;

  const AppList({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onRefresh,
    required this.isLoading,
    this.holderText,
    this.emptyHolder,
    this.onLoadMore,
    this.addBottomPadding = false,
    this.scrollDirection = Axis.vertical,
  }) : assert(holderText != null || emptyHolder != null, 'Empty state placeholder must initialized');

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty && !isLoading) {
      return emptyHolder ?? EmptyList(holderText: holderText!);
    } else {
      return PaginationList(
        items: items,
        itemBuilder: itemBuilder,
        onLoadMore: onLoadMore,
        onRefresh: onRefresh,
        isLoading: isLoading,
        addBottomPadding: addBottomPadding,
        scrollDirection: scrollDirection,
      );
    }
  }
}
