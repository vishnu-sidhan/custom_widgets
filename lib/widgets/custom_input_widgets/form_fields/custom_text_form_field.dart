import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../reactive_widgets.dart';
import '../../../../validator/string_validator.dart';
import 'custom_form_field.dart';

final class CustomTextWidget extends CustomFormField {
  const CustomTextWidget(super.labelText,
      {Key? key,
      bool isObscure = false,
      bool isThreeLine = false,
      this.initialValue,
      this.trailingWidget,
      super.validation,
      super.outLineBorder,
      super.inputType = TextInputType.text})
      : _isThreeLine = isThreeLine,
        _isObscure = isObscure,
        _isRequired = false,
        super(key: key);

  const CustomTextWidget.required(super.labelText,
      {super.key,
      bool isObscure = false,
      bool isThreeLine = false,
      this.initialValue,
      this.trailingWidget,
      super.outLineBorder,
      super.inputType = TextInputType.text})
      : _isThreeLine = isThreeLine,
        _isObscure = isObscure,
        _isRequired = true,
        super(validation: StringValidator.requiredField);

  const CustomTextWidget.password(super.labelText,
      {super.key,
      super.outLineBorder,
      this.initialValue,
      super.inputType = TextInputType.text,
      this.trailingWidget,
      bool isRequired = true})
      : _isRequired = isRequired,
        _isObscure = true,
        _isThreeLine = false,
        super(validation: StringValidator.passwordInputField);

  const CustomTextWidget.email(super.labelText,
      {super.key,
      super.outLineBorder,
      this.initialValue,
      super.inputType = TextInputType.emailAddress,
      this.trailingWidget,
      bool isRequired = true})
      : _isRequired = isRequired,
        _isObscure = false,
        _isThreeLine = false,
        super(validation: StringValidator.emailInputField);

  final bool _isObscure;
  final bool _isThreeLine;
  final bool _isRequired;
  final Widget? trailingWidget;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    textController.text = initialValue ?? '';
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ObxValue((passwordVisible) {
        return TextFormField(
          obscureText: passwordVisible.value,
          readOnly: !editable,
          validator: (val) {
            if (!_isRequired && val?.isNotEmpty != true) {
              return null;
            }
            return validation?.call(val);
          },
          controller: textController,
          // onChanged: (newVal) => value = textController.text,
          keyboardType: inputType,
          autovalidateMode: autovalidateMode,
          maxLines: _isThreeLine ? 3 : 1,
          decoration: InputDecoration(
            suffixIcon:
                _isObscure ? ObscureTextIcon(passwordVisible) : trailingWidget,
            border: outLineBorder ? const OutlineInputBorder() : null,
            label: Text(labelText),
          ),
        );
      }, _isObscure.obs),
    );
  }
}
