import 'package:flutter/material.dart';
import 'package:da3em/features/checkout/controllers/checkout_controller.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/features/splash/controllers/splash_controller.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:da3em/common/basewidget/custom_image_widget.dart';
import 'package:da3em/features/checkout/widgets/payment_method_bottom_sheet_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class ChoosePaymentWidget extends StatelessWidget {
  final bool onlyDigital;
  const ChoosePaymentWidget({super.key, required this.onlyDigital});

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckoutController>(builder: (context, orderProvider, _) {
      return Consumer<SplashController>(builder: (context, configProvider, _) {
        return SizedBox(
            child: Container(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          child: ListTile(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (c) => PaymentMethodBottomSheetWidget(
                        onlyDigital: onlyDigital,
                      ));
            },
            trailing: Icon((IconlyLight.arrow_right)),
            title: Row(
              children: [
                Text('${getTranslated('payment_method', context)}',
                    style: textMedium.copyWith(
                        fontSize: 13, fontWeight: FontWeight.bold)),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
                (orderProvider.paymentMethodIndex != -1)
                    ? Row(
                        children: [
                          SizedBox(
                              width: 40,
                              child: CustomImageWidget(
                                  image:
                                      '${configProvider.configModel?.paymentMethodImagePath}/${configProvider.configModel!.paymentMethods![orderProvider.paymentMethodIndex].additionalDatas!.gatewayImage ?? ''}')),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeSmall),
                            child: Text(configProvider
                                    .configModel!
                                    .paymentMethods![
                                        orderProvider.paymentMethodIndex]
                                    .additionalDatas!
                                    .gatewayTitle ??
                                ''),
                          ),
                        ],
                      )
                    : orderProvider.codChecked
                        ? Text(
                            getTranslated('cash_on_delivery', context) ?? '',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        : orderProvider.offlineChecked
                            ? Text(
                                getTranslated('offline_payment', context) ?? '')
                            : orderProvider.walletChecked
                                ? Text(
                                    getTranslated('wallet_payment', context) ??
                                        '')
                                : InkWell(
                                    onTap: () => showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (c) =>
                                            PaymentMethodBottomSheetWidget(
                                              onlyDigital: onlyDigital,
                                            )),
                                    child: Row(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: Dimensions.paddingSizeSmall),
                                        child: Icon(IconlyLight.paper,
                                            size: 20,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      Text(
                                          '${getTranslated('add_payment_method', context)}',
                                          style: titilliumRegular.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeSmall),
                                          maxLines: 3,
                                          overflow: TextOverflow.fade)
                                    ])),
              ],
            ),
          ),
        ));
      });
    });
  }
}
