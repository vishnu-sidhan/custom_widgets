/// Debit or credit card details
class PlasticMoney {
  String? holderName;
  String? number;
  String? expiry;
  String? securityCode;

  PlasticMoney({
    this.holderName,
    this.number,
    this.expiry,
    this.securityCode,
  });

  PlasticMoney.fromJson(Map<String, dynamic> json) {
    holderName = json['card_holder_name'];
    number = json['card_number'];
    expiry = json['expiry'];
    securityCode = json['security_code'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['card_holder_name'] = holderName;
    data['card_number'] = number;
    data['expiry'] = expiry;
    data['security_code'] = securityCode;
    return data;
  }
}
