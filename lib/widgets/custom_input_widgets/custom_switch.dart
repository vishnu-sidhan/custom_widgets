import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_input_widget.dart';

final class CustomSwitch extends CustomInputWidget<RxBool, bool> {
  const CustomSwitch(super.labelText,
      {super.key,
      this.falseLabel = '',
      this.trueLabel = '',
      this.showLabelText = true});
  final String falseLabel;
  final String trueLabel;
  final bool showLabelText;

  List<Widget> _rowChildren() {
    List<Widget> temp = [
      Obx(
        () => Switch.adaptive(
          value: value,
          activeColor: Colors.green,
          activeTrackColor: Colors.green[200],
          inactiveTrackColor: Colors.red[200],
          inactiveThumbColor: value ? Colors.green : Colors.red,
          onChanged: editable ? (newValue) => value = newValue : null,
        ),
      ),
    ];
    if (showLabelText) {
      temp.insert(0, Text(labelText));
    }
    if (falseLabel != '') {
      temp.insert(showLabelText ? 1 : 0, Text(falseLabel));
    }
    if (trueLabel != '') {
      temp.add(Text(trueLabel));
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _rowChildren(),
    );
  }
}
