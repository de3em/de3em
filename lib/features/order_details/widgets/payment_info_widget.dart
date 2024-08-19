
import 'package:flutter/material.dart';
import 'package:da3em/features/order_details/controllers/order_details_controller.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/features/checkout/widgets/shipping_details_widget.dart';

class PaymentInfoWidget extends StatelessWidget {
  final OrderDetailsController? order;
  const PaymentInfoWidget({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(color: Theme.of(context).highlightColor),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(getTranslated('PAYMENT_STATUS', context)!,
                  style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),

              Text((order!.orders!.paymentStatus != null && order!.orders!.paymentStatus!.isNotEmpty) ?
              order!.orders!.paymentStatus! : 'Digital Payment',
                  style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall))])),


            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(getTranslated('PAYMENT_PLATFORM', context)!,
                  style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),

              Text(order!.orders!.paymentMethod!.replaceAll('_', ' ').capitalize(),
                  style: titilliumBold.copyWith(color: Theme.of(context).primaryColor)),
            ]),
          ]),
    );
  }
}
