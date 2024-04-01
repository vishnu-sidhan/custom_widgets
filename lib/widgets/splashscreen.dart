import 'package:custom_widgets/widgets/reactive_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> splashScreen(Future<String?>? function) => Get.dialog(
    SplashScreen(
      function,
    ),
    barrierDismissible: false);

class SplashScreen extends StatelessWidget {
  final Future<String?>? function;
  static final _loadingString = "Loading".obs;

  static set loadingString(String v) => _loadingString.value = v;

  const SplashScreen(this.function, {super.key});

  void setup() async {
    if (function != null) {
      String? status = await function;
      Get.back();
      if (status != null) {
        Get.snackbar("Status", status);
      }
    }
  }

  Future<void> _futureCall() async {
    setup();
    await Future.delayed(const Duration(minutes: 2));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureCall(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              Get.isDialogOpen == true) {
            Get.back();
            Get.defaultDialog(
                middleText:
                    "Connection Timeout. Could not authenticate in given time. Try again after sometime.");
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator.adaptive(),
              Material(
                color: Colors.transparent,
                child: RxText(
                  _loadingString,
                  style: const TextStyle(color: Colors.grey, fontSize: 24),
                ),
              ).paddingAll(15),
            ],
          );
        });
  }
}
