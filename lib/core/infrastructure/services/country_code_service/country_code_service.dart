import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountryCodeService {
  CountryCodeService._();

  static final CountryCodeService _instance = CountryCodeService._();

  static CountryCodeService get instance => _instance;

  Future<void> init() async {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    String? storedCountryCode = storage.getString('country_code');

    if (storedCountryCode == null) {
      storedCountryCode = _localeCountryCode;
      storage.setString('country_code', _localeCountryCode);
    }

    _countryCode = storedCountryCode;
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

  String get countryCode => _countryCode ?? '';

  String get _localeCountryCode => WidgetsBinding.instance.platformDispatcher.locale.countryCode ?? 'US';

  bool get useUsServer => _usCodes.contains(_countryCode);

  String get serverCountryCode => _serverCountryCode ??= useUsServer ? 'US' : 'EU';
}
