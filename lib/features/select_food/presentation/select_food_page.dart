import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/themes/themes.dart';
import 'package:loopcare_frontend/features/select_food/presentation/widgets/clickable_list_item.dart';

class SelectFoodPage extends StatelessWidget {
  const SelectFoodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dinner 20 February'),
        backgroundColor: AppColors.blueDark,
        flexibleSpace: FlexibleSpaceBar(
          background: Column(
            children: [Text('123')],
          ),
        ),
      ),
      body: Column(
        children: [
          ClickableListItem(
            title: 'Edit this favorite',
            description: '1 glass 300 ml',
          ),
        ],
      )
    );
  }
}
