import 'package:get/get_utils/src/get_utils/get_utils.dart';

final class StringValidator {
  static String? requiredField(String? value) {
    return GetUtils.isNullOrBlank(value)! ? "Required Field" : null;
  }

  static String? categoryInputField(String? value) {
    return GetUtils.isNullOrBlank(value)! ? "Select One Category" : null;
  }

  static String? amountInputField(String? value) {
    return GetUtils.isNullOrBlank(value)! || !GetUtils.isNum(value!)
        ? "Type Only Numbers"
        : null;
  }

  static String? rateValueInputField(String? value) {
    String? a = value?.substring(value.length - 1);
    if (a != "%" && value?.contains("%") == true) {
      return "% symbol is accepted only at last.";
    }
    return GetUtils.isNullOrBlank(value)! ||
            !GetUtils.isNum(
                a == "%" ? value!.substring(0, value.length - 1) : value!)
        ? "Type Only Numbers & % symbol accepted at last."
        : null;
  }

  static String? emailInputField(String? value) {
    return GetUtils.isEmail(value ?? '') ? null : 'Invalid Email Address';
  }

  static String? addListValuesField(List<String>? value) {
    return GetUtils.isNull(value) || value!.isEmpty
        ? "Add Least one category"
        : null;
  }

  static String? mobileNumberField(String? value) {
    RegExp regex = RegExp(r'^[6-9]\d{9}$');
    String? status = requiredField(value);
    bool isEmpty = status != null;
    if (!isEmpty && value!.length != 10) {
      status = 'Number must have exactly Ten Digits';
    } else if (!(regex.hasMatch(value ?? '')) ||
        !GetUtils.isPhoneNumber(value ?? '')) {
      status = 'Enter a Valid Mobile Number';
    }
    return status;
  }

  static String? passwordInputField(String? value) {
    String? status = requiredField(value);
    if (status == null) {
      RegExp regex = RegExp(
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*()_+{}\[\]:;?.,<>]).{8,}$');
      if (!regex.hasMatch(value ?? '')) {
        status = 'The password provided is too weak.';
      }
    }
    return status;
  }

  static String? confirmPasswordField(String? oldValue, String? newValue) {
    return requiredField(newValue) ??
        (newValue!.compareTo(oldValue!) != 0
            ? "Passwords do not match."
            : null);
  }

  static String? pinField(String? value, [int pinLength = 6]) {
    String? status = requiredField(value);
    if (value!.length < pinLength) {
      status = "pin length not matched";
    } else {
      status = null;
    }
    return status;
  }
}
