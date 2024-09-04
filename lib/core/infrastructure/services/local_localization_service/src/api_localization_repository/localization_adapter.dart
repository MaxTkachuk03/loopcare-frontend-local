import 'package:hive/hive.dart';
import 'package:loopcare_frontend/core/infrastructure/hive_service/hive_constants.dart';

class LocalizationAdapter extends TypeAdapter<String> {
  @override
  final typeId = HiveTypeIdConstants.localization;

  @override
  String read(BinaryReader reader) => reader.read() as String;

  @override
  void write(BinaryWriter writer, String obj) => writer.write(obj);
}
