import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../utils/app.utils.dart';
import '../../../validator/string_validator.dart';
import 'custom_form_field.dart';

import '../../../../../constants/country.dart';
import '../../../../../models/mobile_number.dart';
import '../../../../../utils/location.utils.dart';

final class CustomMobieNumberWidget extends CustomFormField {
  CustomMobieNumberWidget(
      {super.key, super.outLineBorder = false, bool isRequired = true})
      : _isRequired = isRequired,
        super('Mobile Number',
            validation: StringValidator.mobileNumberField,
            inputType: TextInputType.number) {
    _popupValuesList = popupValues();
    ever(_country, (callback) {
      _mobile.countryCode = callback.phoneCode;
      rxValue.value = value;
    });
  }

  late final List<PopupMenuEntry<String>> _popupValuesList;
  final MobileNumber _mobile = MobileNumber.empty();
  final bool _isRequired;
  final _country = Rx<Country>(Country.empty);

  String get formattedMobileString {
    if (_mobile.isEmpty) return '';
    StringBuffer buffer = StringBuffer();
    buffer.write("+${_mobile.countryCode}  ");
    buffer.write("${_mobile.value?.substring(0, 5)} ");
    buffer.write("${_mobile.value?.substring(5)}");
    return buffer.toString();
  }

  void init([String? a]) {
    if (a != null && a != '') {
      _mobile.copy(MobileNumber.fromString(a));
      textController.text = formattedMobileString;
      _country.value = LocationUtils.countryFromPhoneCode(_mobile.countryCode!);
    }
  }

  @override
  String get value => _mobile.toString();

  @override
  set value(String v) {
    _mobile.copy(MobileNumber.fromString(v));
  }

  String? _internalValidate(String? val) {
    if (val?.isEmpty != true && !_isRequired) return null;
    String? status = StringValidator.requiredField(_mobile.countryCode);

    if (status != null) {
      status.replaceAll(" ", " Code ");
    }
    status ??= validation!(_mobile.value);
    return status;
  }

  void _onTapField() {
    if (editable && GetUtils.isNullOrBlank(_mobile.countryCode)!) {
      LocationUtils.countryFromUrl.then((val) {
        AppUtils.log("Fetched country from URL: ${val.name}");
        _country.value = val;
      });
    }
  }

  void _onChangedValue(String val) {
    String code = "+${_mobile.countryCode}";
    if (GetUtils.isNullOrBlank(_mobile.countryCode)!) {
      String t = val.removeAllWhitespace.replaceFirst('+', '');
      _country.value = LocationUtils.countryFromPhoneCode(t);
    } else if (val.startsWith(code)) {
      _mobile.value = val.removeAllWhitespace.substring(code.length);
      rxValue.value = value;
    }
  }

  Widget countryFlagImageWidget(String? code) {
    if (code == null || code.isEmpty) {
      return const SizedBox.shrink();
    }
    return Image.asset(
      'assets/images/Flags/${code.toLowerCase()}.png',
      height: 20.0,
      width: 30.0,
      fit: BoxFit.fill,
      package: 'custom_widgets',
    );
  }

  List<PopupMenuEntry<String>> popupValues() {
    List<PopupMenuEntry<String>> a = [];
    for (Country e in Country.values) {
      if (e == Country.empty) continue;
      a.add(PopupMenuItem(
          value: e.phoneCode,
          child: Row(
            children: [
              countryFlagImageWidget(e.isoCode),
              Text(' - +${e.phoneCode}'),
              const Spacer(),
              Text(e.iso3Code)
            ],
          )));
    }
    return a;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Obx(() => TextFormField(
            controller: textController,
            readOnly: !editable,
            autovalidateMode: autovalidateMode,
            validator: _internalValidate,
            onTap: _onTapField,
            onChanged: _onChangedValue,
            inputFormatters: [
              _CountryCodeFormatter(_mobile.countryCode!),
              LengthLimitingTextInputFormatter(
                  _mobile.countryCode!.length + 14),
            ],
            keyboardType: inputType,
            decoration: InputDecoration(
              prefixIcon: Align(
                  alignment: Alignment.bottomCenter,
                  child: countryFlagImageWidget(_country.value.isoCode)),
              isDense: true,
              prefixIconConstraints:
                  const BoxConstraints.tightForFinite(width: 45, height: 30),
              prefix: PopupMenuButton<String>(
                  onSelected: (val) {
                    _country.value = LocationUtils.countryFromPhoneCode(val);
                    textController.clear();
                  },
                  enabled: editable,
                  icon: const Icon(Icons.arrow_drop_down),
                  splashRadius: 5,
                  tooltip: "Select Country Code",
                  itemBuilder: (context) => _popupValuesList),
              border: outLineBorder ? const OutlineInputBorder() : null,
              labelText: labelText,
            ),
          )),
    );
  }
}

class _CountryCodeFormatter extends TextInputFormatter {
  const _CountryCodeFormatter(this.countryCode);
  final String countryCode;

  String _spaceBetweenMobileNo(String val, bool isBackSpaced) {
    if (val.length == 5) {
      if (isBackSpaced) return val.substring(0, 4);
      var a = val.split('');
      a.insert(5, ' ');
      return a.join();
    }
    return val;
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    var buffer = StringBuffer();
    buffer.write("+$countryCode  ");
    if (text.contains('  ')) {
      buffer.write(_spaceBetweenMobileNo(
          text.split('  ')[1], oldValue.text.length > text.length));
    } else if (text != '+$countryCode ') {
      buffer.write(
          _spaceBetweenMobileNo(text, oldValue.text.length > text.length));
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
