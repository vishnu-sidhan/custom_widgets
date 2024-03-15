import 'dart:developer' as developer;

class AppUtils {
  static void log(String message) {
    developer.log(message, name: 'CUSTOM WIDGET');
  }
}
