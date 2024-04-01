import 'package:flutter/material.dart';
import 'package:get/get.dart';

final class RxSwitch extends ObxValue<Rx<dynamic>> {
  RxSwitch(Rx<dynamic> rxVal, {super.key, ValueChanged<bool>? onChanged})
      : assert(rxVal.value.runtimeType == bool,
            "Use only boolean reactive variable."),
        super(
            (p0) => Switch(
                value: p0.value,
                onChanged: (newVal) {
                  p0.value = newVal;
                  onChanged?.call(newVal);
                }),
            rxVal);
}

final class RxText extends ObxValue<Rx<dynamic>> {
  RxText(Rx<dynamic> rxVal, {super.key, TextStyle? style})
      : super((p0) => Text("${p0.value}", style: style), rxVal);
}

final class ObscureTextIcon extends RxIconButtonOnBool {
  ObscureTextIcon(RxBool rxVal, {super.key})
      : super(rxVal,
            onPressed: rxVal.toggle,
            onTrue: Icons.visibility_off,
            onFalse: Icons.visibility);
}

final class RxIconButtonOnBool extends ObxValue<RxBool> {
  RxIconButtonOnBool(RxBool rxVal,
      {super.key, this.onTrue, this.onFalse, required VoidCallback? onPressed})
      : super(
            (p0) => IconButton(
                onPressed: onPressed, icon: Icon(p0.value ? onTrue : onFalse)),
            rxVal);
  final IconData? onTrue;
  final IconData? onFalse;
}

final class ObxPadding extends Padding {
  ObxPadding.all(double all, {super.key, required WidgetCallback builder})
      : super(padding: EdgeInsets.all(all), child: Obx(builder));
  ObxPadding.only(
      {super.key,
      required WidgetCallback builder,
      double left = 0.0,
      double top = 0.0,
      double right = 0.0,
      double bottom = 0.0})
      : super(
            padding: EdgeInsets.only(
                top: top, bottom: bottom, left: left, right: right),
            child: Obx(builder));
  ObxPadding.symmetric(
      {super.key,
      required WidgetCallback builder,
      double vertical = 0.0,
      double horizontal = 0.0})
      : super(
            padding: EdgeInsets.symmetric(
                vertical: vertical, horizontal: horizontal),
            child: Obx(builder));
}
