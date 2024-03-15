import 'package:flutter/foundation.dart';

import '../../models/address.dart';
import 'widgets/custom_input_widgets/form_fields/custom_text_form_field.dart';

mixin AddressDetailMixin {
  final CustomTextWidget address = const CustomTextWidget("Address");
  final CustomTextWidget city = const CustomTextWidget("City");
  final CustomTextWidget state = const CustomTextWidget("State");
  final CustomTextWidget country = const CustomTextWidget("Country");
  final CustomTextWidget pincode = const CustomTextWidget("Pincode");

  @protected
  void toEditAddress(bool value) {
    address.editable = value;
    city.editable = value;
    state.editable = value;
    country.editable = value;
    pincode.editable = value;
  }

  @protected
  void initialiseAddress(Address? data) {
    address.value = data?.name ?? '';
    city.value = data?.city ?? '';
    state.value = data?.state ?? '';
    country.value = data?.country ?? '';
    pincode.value = data?.pincode ?? '';
  }

  Address get addressObj {
    Address addr = Address();
    addr.name = address.value;
    addr.city = city.value;
    addr.state = state.value;
    addr.country = country.value;
    addr.pincode = pincode.value;
    return addr;
  }
}
