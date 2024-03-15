import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_input_widget.dart';

final class CustomSlider extends CustomInputWidget<RxDouble, double> {
  const CustomSlider(super.labelText, {super.key, this.min = 0, this.max = 1});

  final double min, max;

  @override
  Widget build(BuildContext context) {
    if (value < min) {
      value = min;
    }
    return Obx(() => Row(
          children: [
            Text("${value.toInt()}"),
            Slider(
              value: value,
              onChanged: editable
                  ? (newVal) {
                      value = newVal;
                    }
                  : null,
              min: min,
              max: max,
            ),
          ],
        ));
  }
}

final class CustomRangeSlider
    extends CustomInputWidget<Rx<RangeValues>, RangeValues> {
  const CustomRangeSlider(super.labelText,
      {super.key, this.min = 0, this.max = 1});

  final double min, max;

  @override
  Widget build(BuildContext context) {
    value = RangeValues(min, max);
    return Obx(
      () => RangeSlider(
        values: value,
        labels: RangeLabels("${value.start.toInt()}", "${value.end.toInt()}"),
        onChanged: editable
            ? (newVal) {
                value = newVal;
              }
            : null,
        min: min,
        max: max,
      ),
    );
  }
}
