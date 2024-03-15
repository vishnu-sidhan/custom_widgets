import 'package:flutter/material.dart';
import 'package:get/get.dart';

final class RxSwitch extends ObxValue<Rx<dynamic>> {
  RxSwitch(Rx<dynamic> rxVal, {super.key})
      : assert(rxVal.value.runtimeType == bool,
            "Use only boolean reactive variable."),
        super(
            (p0) => Switch(
                value: p0.value, onChanged: (newVal) => p0.value = newVal),
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
