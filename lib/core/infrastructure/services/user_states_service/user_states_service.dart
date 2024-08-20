import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/user_states_service/src/constants/user_states_repository.dart';
import 'package:loopcare_frontend/core/infrastructure/services/user_states_service/src/user_states_model/user_states_model.dart';

@lazySingleton
class UserStatesService {
  final UserStatesRepository _repository;
  final SharedStorageService _storage;

  UserStatesService(this._repository, this._storage);

  int get _accountId => _storage.account?.id ?? -1;

  String? get buddyStatus => _repository.getUserStates(_accountId)?.buddyStatus;

  set buddyStatus(String? status) {
    UserStatesModel? model;
    if (_repository.hasStates(_accountId)) {
      model = _repository.getUserStates(_accountId)?.copyWith(buddyStatus: status);
    }

    model ??= UserStatesModel(id: _accountId, buddyStatus: status);

    _repository.updateUserStates(model);
  }
}