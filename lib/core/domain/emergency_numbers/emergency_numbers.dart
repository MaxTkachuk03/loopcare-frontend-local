import 'package:loopcare_frontend/core/domain/emergency_numbers/emergency_number_data.dart';
import 'package:loopcare_frontend/localization/service/localized_texts.dart';
import 'package:loopcare_frontend/localization/service/localization_extension.dart';

List<EmergencyNumberData> _emergencyNumbersList = [
  EmergencyNumberData(
    type: EmergencyNumberType.phone,
    title: LocalizedTexts.emergencyAssistanceTitle.tr(),
    number: LocalizedTexts.emergencyAssistanceNumber.tr(),
    btnTxt: LocalizedTexts.emergencyAssistanceLabel.tr(),
  ),
  EmergencyNumberData(
    type: EmergencyNumberType.phone,
    title: LocalizedTexts.emergencyUsLifelineTitle.tr(),
    number: LocalizedTexts.emergencyUsLifelineTitleNumber.tr(),
    btnTxt: LocalizedTexts.emergencyUsLifelineTitleLabel.tr(),
  ),
  EmergencyNumberData(
    type: EmergencyNumberType.messenger,
    title: LocalizedTexts.emergencyCrisisChatTitle.tr(),
    number: LocalizedTexts.emergencyCrisisChatUrl.tr(),
    btnTxt: LocalizedTexts.emergencyCrisisChatLabel.tr(),
  ),
  EmergencyNumberData(
    type: EmergencyNumberType.phone,
    title: LocalizedTexts.emergencySelfHarmLineTitle.tr(),
    number: LocalizedTexts.emergencySelfHarmLineNumber.tr(),
    btnTxt: LocalizedTexts.emergencySelfHarmLineLabel.tr(),
  ),
  EmergencyNumberData(
    type: EmergencyNumberType.phone,
    title: LocalizedTexts.emergencyLGBTQLineTitle.tr(),
    number: LocalizedTexts.emergencyLGBTQLineNumber.tr(),
    btnTxt: LocalizedTexts.emergencyLGBTQLineLabel.tr(),
  ),
  EmergencyNumberData(
    type: EmergencyNumberType.phone,
    title: LocalizedTexts.emergencyNationalHotlineTitle.tr(),
    number: LocalizedTexts.emergencyNationalHotlineNumber.tr(),
    btnTxt: LocalizedTexts.emergencyNationalHotlineLabel.tr(),
  ),
  EmergencyNumberData(
    type: EmergencyNumberType.messenger,
    title: LocalizedTexts.emergencyVeteransLineTitle.tr(),
    number: LocalizedTexts.emergencyVeteransLineUrl.tr(),
    btnTxt: LocalizedTexts.emergencyVeteransLineLabel.tr(),
  ),
];

List<EmergencyNumberData> get emergencyList =>
    _emergencyNumbersList.where((entity) => entity.title.isNotEmpty).toList();
