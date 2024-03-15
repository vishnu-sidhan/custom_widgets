import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app.utils.dart';

final class WidgetController<T extends Rx> extends GetxController {
  late final T content;
  late final RxBool editable;
  TextEditingController? textController;
  String? _label;
  Worker? _worker;

  @override
  void onInit() {
    if (T == RxInt) {
      content = 0.obs as T;
    } else if (T == RxDouble) {
      content = 0.0.obs as T;
    } else if (T == RxBool) {
      content = false.obs as T;
    } else if (T == RxString) {
      content = ''.obs as T;
    } else if (T == Rx<List<bool>>) {
      content = Rx(<bool>[]) as T;
    } else if (T == Rx<DateTime>) {
      content = Rx(DateTime.now()) as T;
    } else if (T == Rx<TimeOfDay>) {
      content = Rx(TimeOfDay.now()) as T;
    } else if (T == Rx<RangeValues>) {
      content = Rx(const RangeValues(0, 0)) as T;
    }
    editable = true.obs;
    super.onInit();
  }

  @override
  void onReady() {
    if (_label != null) {
      AppUtils.log(
          "Widget $_label has been initialised with content ${textController?.text ?? content.value}");
    }
    super.onReady();
  }

  @override
  void onClose() {
    AppUtils.log(
        "Deleting widget $_label with content - ${textController?.text ?? content.value} of type ${content.runtimeType}");
    textController?.dispose();
    _worker?.dispose();
    super.onClose();
  }
}

abstract base class CustomInputWidget<T extends Rx, U>
    extends GetWidget<WidgetController<T>> {
  const CustomInputWidget(this.labelText, {super.key});

  @override
  WidgetController<T> get controller {
    var c = super.controller;
    c._label ??= labelText;
    return c;
  }

  T get rxValue => controller.content;

  U get value => rxValue.value;
  set value(U val) => rxValue.value = val;

  bool get editable => controller.editable.value;
  set editable(bool val) => controller.editable.value = val;

  set onChanged(ValueChanged<U> val) {
    controller._worker = ever<U>(rxValue as RxInterface<U>, val);
  }

  final String labelText;

  @override
  Widget build(BuildContext context);
}
