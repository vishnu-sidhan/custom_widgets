import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Center Screen Text Widget
class CSText extends Center {
  const CSText._({super.child});
  factory CSText.comingSoon() => const CSText._(child: Text("Coming Soon"));
  factory CSText.value([String? value]) => CSText._(child: Text(value ?? ''));
}

///App Divider
class AppDivider extends Divider {
  const AppDivider({super.key, super.color = Colors.grey, super.thickness = 1});
}

Future<String?> listViewDialog(String title, Iterable<String> content,
    {String? selectedContent}) async {
  String? t = await Get.defaultDialog(
      title: title,
      titlePadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      content: SizedBox(
        height: Get.height * 0.5,
        width: Get.width * 0.6,
        child: content.isEmpty
            ? Text("No $title contents available")
            : ListView(
                shrinkWrap: true,
                children: content
                    .map((e) => ListTile(
                          leading: selectedContent == e
                              ? const Icon(Icons.done)
                              : null,
                          title: Text(e),
                          onTap: () => Get.back(result: e),
                        ))
                    .toList(),
              ),
      ));
  return t;
}
