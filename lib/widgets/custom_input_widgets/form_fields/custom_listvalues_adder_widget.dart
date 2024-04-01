import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final class CustomListValuesAdderWidget extends CustomFormField {
  CustomListValuesAdderWidget(super.labelText,
      {super.key,
      super.outLineBorder,
      super.inputType = TextInputType.text,
      super.validation,
      List<String>? listOfValues})
      : listValues = (listOfValues ?? []).obs,
        _isSeperated = false;
  CustomListValuesAdderWidget.seperated(super.labelText,
      {super.key,
      super.outLineBorder,
      super.inputType = TextInputType.text,
      super.validation,
      List<String>? listOfValues})
      : listValues = (listOfValues ?? []).obs,
        _isSeperated = true;
  CustomListValuesAdderWidget.required(String labelText, {Key? key})
      : this(labelText,
            key: key, validation: StringValidator.addListValuesField);

  late final RxList<String> listValues;
  final bool _isSeperated;

  @override
  Widget build(BuildContext context) {
    return ObxPadding.only(
        top: paddingValue,
        builder: () => _isSeperated
            ? TextFormField(
                readOnly: true,
                validator: (value) => validation?.call(value),
                controller: textController,
                // onChanged: (newVal) => value = textController.text,
                onTap: !editable
                    ? null
                    : () async {
                        var t = (await Get.to<_ListValuesResult>(
                            () => _ListValuesPage(labelText, listValues, value),
                            routeName: "/select_option"));
                        if (t != null) {
                          value = t.selectedValue ?? "";
                          // listValues.assignAll(t.list);
                        }
                      },
                keyboardType: inputType,
                autovalidateMode: autovalidateMode,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                  border: outLineBorder ? const OutlineInputBorder() : null,
                  label: Text(labelText),
                ),
              )
            : Column(
                children: [
                  editable
                      ? TextFormField(
                          validator: (value) => validation?.call(listValues),
                          controller: textController,
                          // onChanged: (newVal) => value = newVal,
                          keyboardType: inputType,
                          autovalidateMode: autovalidateMode,
                          decoration: InputDecoration(
                            suffixIcon: TextButton.icon(
                                onPressed: () {
                                  listValues.add(value);
                                  value = '';
                                },
                                icon: const Icon(Icons.add),
                                label: const Text("Add")),
                            border: outLineBorder
                                ? const OutlineInputBorder()
                                : null,
                            label: Text(labelText),
                          ),
                        )
                      : const Text(" Categories List",
                          style: TextStyle(fontSize: 20)),
                  Wrap(
                    children: listValues
                        .map((element) => InkWell(
                              onLongPress: editable
                                  ? () => Get.defaultDialog(
                                      title: "Do you want to delete $element?",
                                      onConfirm: () =>
                                          listValues.remove(element),
                                      textCancel: "Back")
                                  : null,
                              child: Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.horizontal(),
                                      color: Colors.black12),
                                  child: Text(element)),
                            ))
                        .toList(),
                  )
                ],
              ));
  }
}

typedef _ListValuesResult = ({List<String> list, String? selectedValue});

class _ListValuesPage extends StatelessWidget {
  const _ListValuesPage(this.title, this._data, this.selectedValue);

  final String title;
  final RxList<String> _data;
  final String selectedValue;

  @override
  Widget build(BuildContext context) {
    void createData() {
      String lTitle = 'Create New $title';
      const content = CustomTextWidget("");
      Get.defaultDialog(
          title: lTitle,
          content: content,
          onConfirm: () {
            _data.add(content.value);
            Get.back();
          });
    }

    void removeData(int index) {
      _data.removeAt(index);
    }

    void onValueSelected(String? newValue) {
      _ListValuesResult a = (list: _data, selectedValue: newValue);
      Get.back(result: a);
    }

    void onPressBack() {
      _ListValuesResult a = (list: _data, selectedValue: selectedValue);
      Get.back(result: a);
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: onPressBack),
        title: Text("Select $title"),
      ),
      body: Obx(() {
        return ListView.builder(
            itemCount: _data.length + 1,
            itemBuilder: (context, index) {
              if (index == _data.length) {
                return ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text('Create'),
                  onTap: createData,
                );
              } else {
                return RadioListTile<String>(
                  title: Text(_data[index]),
                  value: _data[index],
                  groupValue: selectedValue,
                  secondary: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => removeData(index),
                  ),
                  onChanged: onValueSelected,
                );
              }
            });
      }),
    );
  }
}
