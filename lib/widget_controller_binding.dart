import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(() => WidgetController<RxString>());
    Get.create(() => WidgetController<RxInt>());
    Get.create(() => WidgetController<RxDouble>());
    Get.create(() => WidgetController<RxBool>());
    Get.create(() => WidgetController<Rx<List<bool>>>());
    Get.create(() => WidgetController<Rx<DateTime>>());
    Get.create(() => WidgetController<Rx<TimeOfDay>>());
    Get.create(() => WidgetController<Rx<RangeValues>>());
  }
}
