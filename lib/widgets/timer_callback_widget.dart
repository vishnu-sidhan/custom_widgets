import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

final class TimerCallbackController extends GetxController {
  TimerCallbackController(this.duration);
  final Duration duration;
  final timer = 0.obs;
  final isFinished = false.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    timer.value = duration.inSeconds;
    _tick();
  }

  void _tick() => Timer(
        const Duration(seconds: 1),
        () {
          if (timer.value > 0) {
            timer.value--;
            _tick();
          } else {
            isFinished.value = true;
          }
        },
      );

  int get minutes => (timer.value / 60).floor();
  int get seconds => timer.value % 60;

  String get formattedTime =>
      '${minutes > 9 ? '' : '0'}$minutes:${seconds > 9 ? '' : '0'}$seconds';
}

class TimerCallbackWidget extends StatelessWidget {
  const TimerCallbackWidget(this.duration,
      {super.key, this.buttonString, this.onClick});

  final Duration duration;
  final String? buttonString;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GetBuilder(
        init: TimerCallbackController(duration),
        builder: (controller) => Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(controller.formattedTime),
                TextButton(
                  onPressed: controller.isFinished.value ? onClick : null,
                  child: Text(buttonString ?? 'Click'),
                )
              ],
            )),
      ),
    );
  }
}
