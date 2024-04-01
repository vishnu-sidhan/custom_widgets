import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class CardDetailsPage extends StatelessWidget with CardDetailMixin {
  CardDetailsPage({super.key, PlasticMoney? cardDetails}) {
    Future.delayed(const Duration(milliseconds: 100), () {
      initialiseCard(cardDetails);
      toEditCard(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final customSwitch =
        CustomSwitch("To Edit", onPressed: (v) => toEditCard(v));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Card Details"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          cardNumber,
          cardHolderName,
          Row(
            children: [
              Flexible(child: cardExpiry),
              const SizedBox(width: 5),
              Flexible(child: cardSecurityCode),
            ],
          ),
          Align(child: customSwitch)
        ],
      ),
    );
  }
}
