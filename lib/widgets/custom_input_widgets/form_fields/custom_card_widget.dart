import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../validator/card_validator.dart';
import '../../../../../../utils/card.utils.dart';
import '../../reactive_widgets.dart';
import 'custom_form_field.dart';

final class CustomCardWidget extends CustomFormField {
  const CustomCardWidget.card(super.labelText,
      {super.key, this.isObscure = false})
      : _isCard = true,
        super(
            inputType: TextInputType.number,
            validation: CardValidator.validateCardNum);
  const CustomCardWidget.date(super.labelText, {super.key})
      : _isCard = false,
        isObscure = false,
        super(
            inputType: TextInputType.number,
            validation: CardValidator.validateDate);

  final bool isObscure;
  final bool _isCard;

  Widget get _getCardIcon {
    CardType? cardType = CardUtils.getCardTypeFrmNumber(value);
    String img = "";
    Icon? icon;
    switch (cardType) {
      case CardType.master:
        img = 'mastercard.png';
        break;
      case CardType.visa:
        img = 'visa.png';
        break;
      case CardType.verve:
        img = 'verve.png';
        break;
      case CardType.americanExpress:
        img = 'american_express.png';
        break;
      case CardType.discover:
        img = 'discover.png';
        break;
      case CardType.dinersClub:
        img = 'dinners_club.png';
        break;
      // case CardType.jcb:
      //   img = 'jcb.png';
      //   break;
      case CardType.others:
        icon = const Icon(
          Icons.credit_card,
          size: 24.0,
          color: Color(0xFFB8B5C3),
        );
        break;
      default:
        icon = const Icon(
          Icons.warning,
          size: 24.0,
          color: Color(0xFFB8B5C3),
        );
        break;
    }
    Widget? widget;
    if (img.isNotEmpty) {
      widget = Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(
          'assets/images/cardtype/$img',
          width: 20,
          height: 20,
          package: 'custom_widgets',
        ),
      );
    } else {
      widget = icon;
    }
    return widget!;
  }

  @override
  String get value =>
      _isCard ? CardUtils.getCleanedNumber(super.value) : super.value;

  @override
  set value(String v) {
    if (_isCard) {
      v = v.splitMapJoin(RegExp(r'(\d{4})'), onMatch: (m) => '${m.group(1)}  ');
    }
    super.value = v;
  }

  @override
  Widget build(BuildContext context) {
    final passwordVisible = isObscure.obs;
    final cardTypeLogo = _getCardIcon.obs;
    textController.addListener(() => cardTypeLogo.value = _getCardIcon);
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Obx(() {
        return TextFormField(
          obscureText: passwordVisible.value,
          readOnly: !editable,
          validator: (val) => validation?.call(val),
          controller: textController,
          // onChanged: (newVal) => cardTypeLogo.value = _getCardIcon,
          keyboardType: inputType,
          autovalidateMode: autovalidateMode,
          inputFormatters: _isCard
              ? [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  _CardNumberInputFormatter(),
                ]
              : [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                  _CardMonthInputFormatter(),
                ],
          decoration: InputDecoration(
            prefixIcon: _isCard ? cardTypeLogo.value : null,
            suffixIcon: isObscure ? ObscureTextIcon(passwordVisible) : null,
            border: outLineBorder ? const OutlineInputBorder() : null,
            label: Text(labelText),
          ),
        );
      }),
    );
  }
}

class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class _CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
