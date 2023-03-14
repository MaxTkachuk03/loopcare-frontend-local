import 'package:flutter/material.dart';
import 'package:loopcare_frontend/features/nutrition/select_serving/application/dto/serving_type.dart';
import 'package:loopcare_frontend/features/nutrition/select_serving/presentation/widgets/serving_list_item/serving_list_item.dart';

final List<ServingType> servingsList = [
  const ServingType(id: 0, name: 'Pieces (150 g)', calories: '125'),
  const ServingType(id: 1, name: 'Leg  (130 g)', calories: '125'),
  const ServingType(id: 2, name: 'Halve (220 g)', calories: '125'),
  const ServingType(id: 3, name: 'Whole (440 g)', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
  const ServingType(id: 4, name: 'Gram', calories: '125'),
];

class ServingList extends StatefulWidget {
  const ServingList({Key? key}) : super(key: key);

  @override
  State<ServingList> createState() => _ServingListState();
}

class _ServingListState extends State<ServingList> {
  ServingType? _selectedItem;
  final TextEditingController _amountFieldController = TextEditingController();

  void _onListItemPressedHandler(ServingType item) {
    print(item);
    setState(() {
      _selectedItem = item;
    });
  }

  @override
  void dispose() {
    _amountFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: servingsList.length,
      itemBuilder: (BuildContext context, int index) {
        final ServingType listItem = servingsList[index];

        return ServingListItem(
            item: listItem,
            onPressed: _onListItemPressedHandler,
            isSelected: _selectedItem?.id == listItem.id,
            inputController: _amountFieldController);
      },
    );
  }
}
