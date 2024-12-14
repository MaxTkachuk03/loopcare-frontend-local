import 'dart:async';

import 'package:flutter/material.dart';

const double _kContentPadding = 8.0;
const double _kInnerContentPadding = 16.0;
const double kHolderHeight = 40;
const Duration _kRefreshDuration = Duration(milliseconds: 500);

class PaginationList<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Function() onRefresh;
  final VoidCallback? onLoadMore;
  final int? parentIndex;
  final bool isLoading;
  final bool addBottomPadding;
  final Axis scrollDirection;

  const PaginationList({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onRefresh,
    this.onLoadMore,
    this.parentIndex,
    this.isLoading = false,
    this.addBottomPadding = false,
    this.scrollDirection = Axis.vertical,
  });

  @override
  State<PaginationList<T>> createState() => _PaginationListState<T>();
}

class _PaginationListState<T> extends State<PaginationList<T>> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScrollChangeListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScrollChangeListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      scrollDirection: widget.scrollDirection,
      controller: _scrollController,
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(
            top: _kContentPadding,
            bottom:
                widget.addBottomPadding ? _kInnerContentPadding + kHolderHeight : _kContentPadding,
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => widget.itemBuilder(
                context,
                widget.items[index],
              ),
              childCount: widget.items.length,
            ),
          ),
        ),
        if (widget.isLoading)
          const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(_kInnerContentPadding),
                child: CircularProgressIndicator(),
              ),
            ),
          ),
      ],
    );

    content = RefreshIndicator(
      child: content,
      onRefresh: () => Future.delayed(
        _kRefreshDuration,
        widget.onRefresh,
      ),
    );

    return content;
  }

  void _onScrollChangeListener() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (!widget.isLoading && currentScroll == maxScroll) {
      widget.onLoadMore?.call();
    }
  }
}
