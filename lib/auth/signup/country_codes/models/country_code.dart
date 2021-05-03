class CountryCode {
  final String name;
  final String dialCode;
  final String flag;

  CountryCode(this.name, this.dialCode, this.flag);

  CountryCode.fromJSON(Map<String, String> json)
      : name = json['name'],
        dialCode = json['dialCode'],
        flag = json['flag'];

  Map<String, String> toJSON() {
    return {
      "name": name,
      "dialCode": dialCode,
      "flag": flag
    };
  }

  @override
  String toString() {
    return 'CountryCode{name: $name, dialCode: $dialCode, flag: $flag}';
  }
}
