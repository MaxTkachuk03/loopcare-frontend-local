import 'package:auto_route/auto_route.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:loopcare_frontend/core/domain/account/account.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.gr.dart';
import 'package:loopcare_frontend/features/authentication/application/authentication_bloc.dart';
import 'package:loopcare_frontend/injection.dart';

class StoredAccountService {

  static Account? getAccount() {
    try {
      return getIt<SharedStorageService>().account;
    } catch (e) {
      getIt<AuthenticationBloc>().add(const AuthenticationEvent.logout());

      HydratedBloc.storage.clear();
      getIt<SharedStorageService>().cleanStorage().whenComplete(
        () {
          kOverlayContext.router.replaceAll([const SplashRoute()]);
        },
      );

      return null;
    }
  }
}