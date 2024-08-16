import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/services/user_states_service/src/api_user_states_repository/user_states_model_adapter.dart';
import 'package:loopcare_frontend/core/infrastructure/services/user_states_service/src/constants/user_states_repository.dart';
import 'package:loopcare_frontend/core/infrastructure/services/user_states_service/src/user_states_model/user_states_model.dart';
import 'package:path_provider/path_provider.dart';

@Injectable(as: UserStatesRepository)
class ApiUserStatesRepository implements UserStatesRepository {
  Box<UserStatesModel> get _box => Hive.box('user_states');

  @PostConstruct()
  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(UserStatesModelAdapter());
    await Hive.openBox<UserStatesModel>('user_states');
  }

  @override
  bool hasStates(int id) => _box.containsKey(id);

  @override
  UserStatesModel? getUserStates(int id) => _box.get(id);

  @override
  Future<void> updateUserStates(UserStatesModel user) async {
    _box.put(user.id, user);
  }
}