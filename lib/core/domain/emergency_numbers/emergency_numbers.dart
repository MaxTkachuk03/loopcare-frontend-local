import 'package:loopcare_frontend/core/domain/emergency_numbers/emergency_number_data.dart';

List<EmergencyNumberData> emergencyNumbersList = [
  const EmergencyNumberData(
    type: EmergencyNumberType.phone,
    title: 'Emergency assistance: (call or text)',
    number: '911',
    btnTxt: '911',
  ),
  const EmergencyNumberData(
    type: EmergencyNumberType.phone,
    title: 'U.S suicide and crisis lifeline (call or text)',
    number: '988',
    btnTxt: '988',
  ),
  const EmergencyNumberData(
    type: EmergencyNumberType.messenger,
    title: 'Lifeline Crisis Chat',
    number: 'https://988lifeline.org/chat',
    btnTxt: 'Live messenger',
  ),
  const EmergencyNumberData(
    type: EmergencyNumberType.phone,
    title: 'Self-harm Line',
    number: '1-800-366-8288',
    btnTxt: '1-800-366-8288',
  ),
  const EmergencyNumberData(
    type: EmergencyNumberType.phone,
    title: 'LGBTQ Youth Suicide Hotline (Trevor Project)',
    number: '1-866-488-786',
    btnTxt: '1-866-488-786',
  ),
  const EmergencyNumberData(
    type: EmergencyNumberType.phone,
    title: 'National Crisis Hotline (Anorexia & Bulimia)',
    number: '1-800-233-4357',
    btnTxt: '1-800-233-4357',
  ),
  const EmergencyNumberData(
    type: EmergencyNumberType.none,
    title: 'Veterans Line',
    number: 'https://veteranscrisisline.net/',
    btnTxt: 'Veterans Line',
  ),
];
