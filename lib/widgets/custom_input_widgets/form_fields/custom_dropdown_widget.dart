import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

final class CustomDropdownWidget extends CustomFormField {
  const CustomDropdownWidget(super.labelText,
      {super.key, required this.dropDownList, this.onSelected})
      : super(validation: StringValidator.categoryInputField);

  final List<String>? dropDownList;
  final ValueChanged<String?>? onSelected;

  @override
  Widget build(BuildContext context) {
    return ObxPadding.only(
        top: paddingValue,
        builder: () => DropdownButtonFormField<String>(
              value: value == '' ? null : value,
              validator: (value) => validation?.call(value),
              autovalidateMode: autovalidateMode,
              decoration: InputDecoration(
                  labelText: labelText,
                  border: outLineBorder ? const OutlineInputBorder() : null,
                  floatingLabelBehavior: FloatingLabelBehavior.auto),
              items: dropDownList?.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
              onChanged: !editable
                  ? null
                  : (v) {
                      value = v ?? '';
                      onSelected?.call(v);
                    },
            ));
  }
}
