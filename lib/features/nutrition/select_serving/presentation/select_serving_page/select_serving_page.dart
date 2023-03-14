import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';

class SelectServingPage extends StatefulWidget {
  const SelectServingPage({Key? key}) : super(key: key);

  @override
  State<SelectServingPage> createState() => _SelectServingPageState();
}

class _SelectServingPageState extends State<SelectServingPage> {
  late final _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController()..addListener(() => setState(() {}));

    super.initState();
  }

  double get _horizontalTitlePadding {
    const kBasePadding = 15.0;
    const kMultiplier = 0.5;
    const kExpandedHeight = 100;

    if (_scrollController.hasClients) {
      if (_scrollController.offset < (kExpandedHeight / 2)) {
        // In case 50%-100% of the expanded height is viewed
        return kBasePadding;
      }

      if (_scrollController.offset > (kExpandedHeight - kToolbarHeight)) {
        // In case 0% of the expanded height is viewed
        return (kExpandedHeight / 2 - kToolbarHeight) * kMultiplier +
            kBasePadding;
      }

      // In case 0%-50% of the expanded height is viewed
      return (_scrollController.offset - (kExpandedHeight / 2)) * kMultiplier +
          kBasePadding;
    }

    return kBasePadding;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: Theme.of(context).textTheme.headline5?.copyWith(
              color: AppColors.white,
            ),
        title: const Text('Dinner 20 February'),
        backgroundColor: AppColors.blueAppBar,
      ),
      body: SizedBox(),
    );
  }
}
