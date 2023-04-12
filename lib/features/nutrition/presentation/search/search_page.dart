import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_app_bar.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_result_list.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SearchAppBar(),
      body: SafeArea(
        child: ScrollableContainer(
          child: SearchResultList(),
        ),
      ),
    );
  }
}
