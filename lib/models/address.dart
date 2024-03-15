final class Address {
  String? name;
  String? city;
  String? state;
  String? country;
  String? pincode;
  Address({
    this.name,
    this.city,
    this.state,
    this.country,
    this.pincode,
  });

  Address.fromJson(Object? data) {
    Map<String, dynamic> json = data as Map<String, dynamic>;
    name = json["name"];
    city = json["city"];
    state = json["state"];
    country = json["country"];
    pincode = json["pincode"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["name"] = name;
    data["city"] = city;
    data["state"] = state;
    data["country"] = country;
    data["pincode"] = pincode;
    return data;
  }

  String get getFullAddress {
    String addr = '';
    if (name != null) {
      addr += '$name, ';
    }
    if (city != null) {
      addr += '$city, ';
    }
    if (state != null) {
      addr += '$state, ';
    }
    if (country != null) {
      addr += '$country, ';
    }
    if (pincode != null) {
      addr += 'Pincode - $pincode ';
    }
    return addr;
  }
}
