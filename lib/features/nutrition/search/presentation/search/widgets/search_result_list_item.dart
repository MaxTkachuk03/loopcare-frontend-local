import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/nutrition/application/dto/search/search_result.dart';

class SearchResultListItem extends StatelessWidget {
  final SearchResult item;
  final String routePath;
  final Color imageOverlayColor;

  const SearchResultListItem({
    Key? key,
    required this.item,
    required this.routePath,
    required this.imageOverlayColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 96,
    );
  }

  void _onItemPressed(BuildContext context) {
    context.router.pushNamed(routePath);
  }
}
