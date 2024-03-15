import 'package:flutter/foundation.dart';

import '../../models/plastic_money.dart';
import 'widgets/custom_input_widgets/form_fields/custom_card_widget.dart';
import 'widgets/custom_input_widgets/form_fields/custom_number_widget.dart';
import 'widgets/custom_input_widgets/form_fields/custom_text_form_field.dart';

mixin CardDetailMixin {
  final cardHolderName = const CustomTextWidget.required("Card holder name");
  final cardNumber = const CustomCardWidget.card("Number", isObscure: true);
  final cardExpiry = const CustomCardWidget.date("MM/YY");
  final cardSecurityCode = const CustomNumberWidget.pin("Security code",
      outlineBorder: true, helperText: "CVV", maxLength: 3);

  @protected
  void initialiseCard(PlasticMoney? card) {
    cardHolderName.value = card?.holderName ?? '';
    cardNumber.value = card?.number ?? '';
    cardExpiry.value = card?.expiry ?? '';
    cardSecurityCode.value = card?.securityCode ?? '';
  }

  @protected
  void toEditCard(bool v) {
    cardHolderName.editable = v;
    cardNumber.editable = v;
    cardExpiry.editable = v;
    cardSecurityCode.editable = v;
  }

  PlasticMoney get cardObj {
    PlasticMoney card = PlasticMoney();
    card.holderName = cardHolderName.value;
    card.number = cardNumber.value;
    card.expiry = cardExpiry.value;
    card.securityCode = cardSecurityCode.value;
    return card;
  }
}
