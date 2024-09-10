import 'package:hive/hive.dart';
import 'package:loopcare_frontend/core/infrastructure/hive_service/hive_constants.dart';
import 'package:loopcare_frontend/core/infrastructure/services/user_states_service/src/user_states_model/user_states_model.dart';

class UserStatesModelAdapter extends TypeAdapter<UserStatesModel> {
  @override
  final typeId = HiveTypeIdConstants.userStates;

  @override
  UserStatesModel read(BinaryReader reader) {
    final json = reader.readMap() as Map<String, dynamic>;

    return UserStatesModel.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, UserStatesModel obj) {
    writer.writeMap(obj.toJson(), writeLength: false);
  }
}
