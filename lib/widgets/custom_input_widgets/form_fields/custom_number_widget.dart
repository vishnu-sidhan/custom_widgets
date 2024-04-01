import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../validator/string_validator.dart';
import '../../reactive_widgets.dart';
import 'custom_form_field.dart';

final class CustomNumberWidget extends CustomFormField {
  const CustomNumberWidget(super.labelText,
      {super.key,
      super.outLineBorder = false,
      this.isPercent = false,
      String? helperText,
      this.trailingWidget,
      this.maxLength,
      super.validation})
      : _helperText = helperText,
        super(inputType: TextInputType.number);

  const CustomNumberWidget.required(String labelText,
      {Key? key,
      String? helperText,
      bool outlineBorder = false,
      Widget? trailing})
      : this(labelText,
            key: key,
            outLineBorder: outlineBorder,
            trailingWidget: trailing,
            validation: StringValidator.amountInputField,
            helperText: helperText);

  const CustomNumberWidget.pin(String labelText,
      {Key? key,
      String? helperText,
      bool outlineBorder = false,
      int maxLength = 6})
      : this(labelText,
            key: key,
            outLineBorder: outlineBorder,
            trailingWidget: null,
            validation: StringValidator.pinField,
            helperText: helperText,
            maxLength: maxLength);

  const CustomNumberWidget.rateValue(String labelText,
      {Key? key, bool outlineBorder = false, Widget? trailing})
      : this(labelText,
            key: key,
            isPercent: null,
            outLineBorder: outlineBorder,
            trailingWidget: trailing,
            validation: StringValidator.rateValueInputField,
            helperText: "Add % symbol to calculate percent");

  const CustomNumberWidget.percent(String labelText,
      {Key? key, bool outlineBorder = false, Widget? trailing})
      : this(labelText,
            key: key,
            isPercent: true,
            outLineBorder: outlineBorder,
            trailingWidget: trailing,
            validation: StringValidator.amountInputField,
            helperText: "Enter a percentage Value");

  final String? _helperText;
  final bool? isPercent;
  final Widget? trailingWidget;
  final int? maxLength;

  bool get _isPin => validation == StringValidator.pinField;
  bool get _isRateValue => validation == StringValidator.rateValueInputField;

  @override
  Widget build(BuildContext context) {
    textController.text = _isRateValue ? "0" : value;
    final isObscure = _isPin.obs;
    return ObxPadding.only(
        top: paddingValue,
        builder: () {
          return TextFormField(
            readOnly: !editable,
            obscureText: isObscure.value,
            validator: (val) => _isPin
                ? validation!.call(val, maxLength)
                : validation?.call(val),
            autovalidateMode: autovalidateMode,
            controller: textController,
            onChanged: (val) {
              if (value == "" && _isRateValue) {
                textController.text = "0";
              }
              // value = textController.text;
            },
            maxLength: maxLength,
            inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
            keyboardType: inputType,
            decoration: InputDecoration(
              helperText: _helperText,
              border: outLineBorder ? const OutlineInputBorder() : null,
              suffixIcon: _isPin ? ObscureTextIcon(isObscure) : trailingWidget,
              label: Text(labelText),
            ),
          );
        });
  }
}
