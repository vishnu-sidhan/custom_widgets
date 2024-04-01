import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DisplayValuePosition { left, center, right }

final class CustomValueAdder extends CustomInputWidget<RxInt, int> {
  const CustomValueAdder(super.labelText,
      {super.key,
      this.max = 5,
      this.displayValuePosition = DisplayValuePosition.left});

  final int max;
  final DisplayValuePosition displayValuePosition;

  List<Widget> _rowChildren() {
    List<Widget> temp = [
      ObxPadding.all(8,
          builder: () => IconButton.outlined(
              onPressed: (value <= 0)
                  ? null
                  : () {
                      value -= 1;
                    },
              icon: const Icon(Icons.remove))),
      ObxPadding.all(8,
          builder: () => IconButton.outlined(
              onPressed: value >= max
                  ? null
                  : () {
                      value += 1;
                    },
              icon: const Icon(Icons.add))),
    ];
    temp.insert(displayValuePosition.index,
        ObxPadding.all(8, builder: () => Text("$value")));
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _rowChildren());
  }
}
