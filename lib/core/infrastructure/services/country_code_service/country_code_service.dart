import 'package:flutter/widgets.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/injection.dart';

class CountryCodeService {
  static final CountryCodeService _instance = CountryCodeService._internal();

  CountryCodeService._internal() {
    _countryCode = countryCode;
    _serverCountryCode = serverCountryCode;
  }

  static CountryCodeService get instance {
    return _instance;
  }

  static const List<String> _usCodes = [
    'US',
    'CA',
    'CU',
    'MX',
    'GT',
    'NI',
    'CR',
    'PA',
    'CO',
    'VE',
    'EC',
    'GY',
    'SR',
    'GF',
    'PE',
    'BR',
    'BO',
    'PY',
    'CL',
    'AR',
    'UY',
  ];


  String? _countryCode;

  String? _serverCountryCode;

  String get countryCode {
    final storage = getIt<SharedStorageService>();
    return _countryCode ??= storage.countryCode ??= _localeCountryCode;
  }

  String get _localeCountryCode => WidgetsBinding.instance.platformDispatcher.locale.countryCode ?? 'US';

  bool get useUsServer => _usCodes.contains(_countryCode);

  String get serverCountryCode => _serverCountryCode ??= useUsServer ? 'US' : 'EU';
}
