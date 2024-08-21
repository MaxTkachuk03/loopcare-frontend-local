import 'package:hive/hive.dart';
import 'package:loopcare_frontend/core/infrastructure/services/user_states_service/src/user_states_model/user_states_model.dart';
import 'package:loopcare_frontend/features/account/presentation/buddy_page/application/buddy_status.dart';

class UserStatesModelAdapter extends TypeAdapter<UserStatesModel> {
  @override
  final typeId = 0;

  @override
  UserStatesModel read(BinaryReader reader) {
    final id = reader.read() as int;
    final buddyStatusIndex = reader.read() as int?;
    final buddyStatus = buddyStatusIndex != null ? BuddyStatus.values[buddyStatusIndex] : null;

    return UserStatesModel(id: id, buddyStatus: buddyStatus);
  }

  @override
  void write(BinaryWriter writer, UserStatesModel obj) {
    writer
      ..write(obj.id)
      ..write(obj.buddyStatus?.index);
  }
}
