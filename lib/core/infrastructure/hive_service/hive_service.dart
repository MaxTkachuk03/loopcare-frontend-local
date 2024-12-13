import 'package:hive/hive.dart';
import 'package:loopcare_frontend/core/infrastructure/hive_service/hive_constants.dart';
import 'package:path_provider/path_provider.dart';

Future<void> initHive() async {
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  await Hive.openBox<String>(HiveBoxConstants.localization);
}
