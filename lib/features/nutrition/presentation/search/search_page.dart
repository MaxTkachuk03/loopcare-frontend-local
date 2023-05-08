import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/dto/search_mode.dart';
import 'package:loopcare_frontend/features/nutrition/application/search/search_bloc.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_app_bar.dart';
import 'package:loopcare_frontend/features/nutrition/presentation/search/widgets/search_result_list.dart';

class SearchPage extends StatefulWidget {
  final void Function(SearchItem item) onItemTap;
  final SearchMode? mode;

  const SearchPage({
    Key? key,
    required this.onItemTap,
    this.mode,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();

    context.read<SearchBloc>().add(const SearchEvent.resetData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(mode: widget.mode),
      body: SafeArea(
        child: ScrollableContainer(
          child: SearchResultList(onItemTap: widget.onItemTap),
        ),
      ),
    );
  }
}
