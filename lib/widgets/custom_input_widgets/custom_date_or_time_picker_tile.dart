import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final class CustomDatePickerTile
    extends CustomInputWidget<Rx<DateTime>, DateTime> {
  const CustomDatePickerTile(super.labelText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListTile(
          leading: const Icon(Icons.date_range),
          title: Text("${value.day}/${value.month}/${value.year}"),
          trailing: const Icon(Icons.arrow_drop_down_sharp),
          onTap: editable
              ? () async {
                  value = await showDatePicker(
                          context: context,
                          initialDate: value,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100)) ??
                      value;
                }
              : null,
        ));
  }
}

final class CustomTimePickerTile
    extends CustomInputWidget<Rx<TimeOfDay>, TimeOfDay> {
  const CustomTimePickerTile(super.labelText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListTile(
          leading: const Icon(Icons.date_range),
          title: Text(value.format(context)),
          trailing: const Icon(Icons.arrow_drop_down_sharp),
          onTap: editable
              ? () async {
                  value = await showTimePicker(
                          context: context, initialTime: value) ??
                      value;
                }
              : null,
        ));
  }
}
