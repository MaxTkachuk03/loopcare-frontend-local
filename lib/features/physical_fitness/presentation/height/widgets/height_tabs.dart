import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/measurement_system_type.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/unit_field.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/unit_tabs.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/height_conversion_utils.dart';

const cm = 'cm';
const ft = 'ft';
const inches = 'In';

class HeightTabs extends StatefulWidget {
  const HeightTabs({Key? key}) : super(key: key);

  @override
  State<HeightTabs> createState() => _HeightTabsState();
}

class _HeightTabsState extends State<HeightTabs> {
  TextEditingController cmController = TextEditingController(text: '');
  TextEditingController ftController = TextEditingController(text: '');
  TextEditingController inController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return UnitTabs(
      tabBarViewChildren: [
        UnitField(
          unit: cm,
          controller: cmController,
          // isDecimal: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UnitField(
              unit: ft,
              controller: ftController,
            ),
            const SizedBox(
              width: 12.0,
            ),
            UnitField(
              unit: inches,
              controller: inController,
            ),
          ],
        ),
      ],
      onTabChanged: _onTabChanged,
    );
  }

  _onTabChanged(MeasurementSystemType unitType) {
    if (unitType == MeasurementSystemType.metric) {
      final ftText = ftController.text;
      final inText = inController.text;
      if (ftText == '') return;

      cmController.text = '${HeightConversionUtils.convertFeetAndInchesToCM(
        double.parse(ftText),
        inText == '' ? 0 : double.parse(inText),
      )}';
    } else {
      final cmText = cmController.text;
      if (cmText == '') return;

      ftController.text = '${HeightConversionUtils.convertCMtoFeet(
        double.parse(cmText),
      )}';
      inController.text = '${HeightConversionUtils.convertCMtoInches(
        double.parse(cmText),
      )}';
    }
  }
}
