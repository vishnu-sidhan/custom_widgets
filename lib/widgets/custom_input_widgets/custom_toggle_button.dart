import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_input_widget.dart';

final class CustomToggleButton
    extends CustomInputWidget<Rx<List<bool>>, List<bool>> {
  const CustomToggleButton(super.labelText,
      {super.key,
      required this.children,
      this.isUniqueSelection = true,
      this.alwaysEditable,
      this.anyOneSelected = false});

  final List children;
  final bool isUniqueSelection;
  final bool? alwaysEditable;
  final bool anyOneSelected;

  // List<bool> get isSelected => rxValue.value;

  // set isSelected(List<bool> v) {
  //   rxValue.value = v;
  //   // rxValue.refresh();
  // }

  Widget _toggleButton() {
    return Obx(() {
      return ToggleButtons(
          borderRadius: BorderRadius.circular(12),
          isSelected: value.toList(),
          onPressed: alwaysEditable ?? editable
              ? (newVal) {
                  List<bool> t = value;
                  if (isUniqueSelection) {
                    for (int i = 0; i < value.length; i++) {
                      t[i] = i == newVal;
                    }
                  } else {
                    t[newVal] = !value[newVal];
                  }
                  value = t;

                  // onChanged?.call(newVal);
                }
              : null,
          children: children
              .map((e) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text('$e'),
                  ))
              .toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    value = List.generate(children.length, (i) => anyOneSelected && i == 0);
    return labelText == ""
        ? _toggleButton()
        : Column(
            children: [
              Text(labelText),
              const SizedBox(height: 10),
              _toggleButton()
            ],
          );
  }
}
