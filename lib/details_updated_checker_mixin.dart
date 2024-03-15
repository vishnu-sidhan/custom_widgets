import 'package:custom_widgets/custom_widgets.dart';
import 'package:custom_widgets/utils/app.utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin DetailsUpdatedCheckerMixin {
  bool _isInitialised = false;
  bool? _force;

  bool get isUpdated => _isUpdated.values.any((element) => element);
  final Map<String, bool> _isUpdated = {};
  final Map<String, dynamic> _initialData = {};

  @protected
  void setUpdaterCheck(bool? v) => _force = v;

  @protected
  void initialiseToSaveChecker(List<CustomInputWidget> widgets) {
    if (_isInitialised) {
      AppUtils.log("Already Initialised checker Variables");
    } else {
      AppUtils.log("Initialising checker Variables");
      for (var i in widgets) {
        _initialData[i.labelText] = i.value;
        _isUpdated[i.labelText] = false;
        i.onChanged = (callback) {
          _isUpdated[i.labelText] = _initialData[i.labelText] != callback;
        };
      }
      _isInitialised = true;
    }
  }

  @protected
  void resetUpdatedChecker(List<CustomInputWidget> widgets) {
    AppUtils.log("Reseting checker variable");
    for (var i in widgets) {
      _initialData[i.labelText] = i.value;
      _isUpdated[i.labelText] = false;
    }
    _force = null;
  }

  BackButton get onUpdatedCheckerWidget => BackButton(onPressed: () async {
        if (Get.isSnackbarOpen) await Get.closeCurrentSnackbar();
        if (_force ?? isUpdated) {
          Get.defaultDialog(
              title: "Changes Made!",
              middleText: "Do you want to discard the changes made?",
              textConfirm: "Yes",
              textCancel: "No",
              onConfirm: () => Get.close(2));
        } else {
          Get.back();
        }
      });
}
