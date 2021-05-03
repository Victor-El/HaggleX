import 'package:flutter/material.dart';
import 'package:haggle_x/auth/signup/country_codes/models/country_code.dart';

class CountryCodeChangeNotifier extends ChangeNotifier {
  CountryCode _countryCode = CountryCode("Nigeria", "+234",  "https://www.countryflags.io/NG/flat/64.png");

  void updateCountryCode(CountryCode code) {
    _countryCode = code;
    notifyListeners();
  }

  CountryCode getCountryCode() {
    return _countryCode;
  }
}