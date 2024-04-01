import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom_input_widget.dart';

abstract base class CustomFormField
    extends CustomInputWidget<RxString, String> {
  const CustomFormField(
    super.labelText, {
    super.key,
    this.validation,
    this.inputType,
    this.outLineBorder = true,
  });

  final Function? validation;
  final bool outLineBorder;
  final TextInputType? inputType;
  final AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction;

  TextEditingController get textController =>
      controller.textController ??= TextEditingController();

  @override
  String get value => controller.textController?.text ?? super.value;

  @override
  set value(String v) => controller.textController != null
      ? textController.text = v
      : super.value = v;

  @override
  set onChanged(ValueChanged<String> val) {
    controller.textController != null
        ? controller.textController
            ?.addListener(() => val(controller.textController!.text))
        : super.onChanged = val;
  }

  void clearValue() {
    value = '';
  }

  @protected
  final double paddingValue = 20;
}
