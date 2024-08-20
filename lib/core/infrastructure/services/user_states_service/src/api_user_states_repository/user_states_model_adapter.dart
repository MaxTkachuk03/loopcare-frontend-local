import 'package:hive/hive.dart';
import 'package:loopcare_frontend/core/infrastructure/services/user_states_service/src/user_states_model/user_states_model.dart';

class UserStatesModelAdapter extends TypeAdapter<UserStatesModel> {
  @override
  final typeId = 0;

  @override
  UserStatesModel read(BinaryReader reader) {
    return UserStatesModel.fromJson(reader.read());
  }

  @override
  void write(BinaryWriter writer, UserStatesModel obj) {
    writer.write(obj.toJson());
  }
}