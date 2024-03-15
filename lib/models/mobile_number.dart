final class MobileNumber {
  String? countryCode;
  String? value;
  MobileNumber({this.countryCode, this.value});
  factory MobileNumber.empty() => MobileNumber(countryCode: '', value: '');

  MobileNumber.fromMap(Map<String, String> json) {
    countryCode = json['country_code'];
    value = json['mobile_number'];
  }

  /// String must include '+' and Country Code before the number.
  MobileNumber.fromString(String? number) {
    assert(number?[0] == '+');
    number = number?.replaceAll(' ', '');
    int length = number?.length ?? 0;
    if (length >= 10) {
      countryCode = number?.substring(1, length - 10);
      value = number?.substring(length - 10);
    }
  }

  Map<String, String?> toJson() {
    Map<String, String?> data = {};
    data['country_code'] = countryCode;
    data['mobile_number'] = value;
    return data;
  }

  void copy(MobileNumber newValue) {
    countryCode = newValue.countryCode;
    value = newValue.value;
  }

  @override
  String toString() {
    return countryCode != null && value != null ? '+$countryCode$value' : '';
  }
}

extension Ext on MobileNumber {
  bool get isEmpty =>
      (countryCode == null || countryCode == '') &&
      (value == null || value == '');
}
