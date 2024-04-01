import 'package:custom_widgets/custom_widgets.dart';
import 'package:custom_widgets/widget_controller_binding.dart';
import 'package:example/card_details_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    WidgetControllerBinding().dependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  Future<void> navigate(Widget page, BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: ListView(
          children: [
            ListTile(
              title: const Text("Card Details"),
              subtitle: const Text("Long press to view with details"),
              onTap: () => navigate(CardDetailsPage(), context),
              onLongPress: () => navigate(
                  CardDetailsPage(
                    cardDetails: PlasticMoney(
                        holderName: 'John Doe',
                        number: '1111222233334444',
                        expiry: '02/28',
                        securityCode: '123'),
                  ),
                  context),
            ),
          ],
        ));
  }
}
