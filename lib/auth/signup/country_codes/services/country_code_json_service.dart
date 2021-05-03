import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:haggle_x/auth/signup/country_codes/models/country_code.dart';
import 'package:haggle_x/utils/constants.dart';

class CountryCodeService {
  static final CountryCodeService _countryCodeService = null;

  CountryCodeService._private();

  Future<String> getCountryCodesAsString() async {
    var json = await rootBundle.loadString(COUNTRY_CODE_JSON_PATH);
    return json;
  }

  Future<List<CountryCode>> getCountryCodes() async {
    var jsonString = await getCountryCodesAsString();
    List<CountryCode> jsonMap = List<CountryCode>.from(jsonDecode(jsonString).map((e) {
      return CountryCode.fromJSON({
        "name": e['name'],
        "dialCode": e['dialCode'],
        "flag": e['flag'],
      });
    }));
    print(jsonMap);
    return jsonMap;
  }

  factory CountryCodeService.getInstance() => _countryCodeService == null
      ? CountryCodeService._private()
      : _countryCodeService;
}
