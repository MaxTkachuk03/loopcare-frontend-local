import 'package:loopcare_frontend/core/infrastructure/services/user_states_service/src/user_states_model/user_states_model.dart';

abstract class UserStatesRepository {
  bool hasStates(int id);

  UserStatesModel? getUserStates(int id);

  Future<void> updateUserStates(UserStatesModel data);
}
