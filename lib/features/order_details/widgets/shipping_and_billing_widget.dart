import 'package:da3em/features/product_details/widgets/form_checkout.dart';
import 'package:flutter/material.dart';
import 'package:da3em/features/order_details/controllers/order_details_controller.dart';
import 'package:da3em/features/order_details/widgets/icon_with_text_row_widget.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/theme/controllers/theme_controller.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:provider/provider.dart';

class ShippingAndBillingWidget extends StatelessWidget {
  final OrderDetailsController orderProvider;
  const ShippingAndBillingWidget({super.key, required this.orderProvider});

  @override
  Widget build(BuildContext context) {
    return orderProvider.orders!.orderType == 'POS'
        ? Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(Dimensions.homePagePadding),
            color: Theme.of(context).highlightColor,
            child: Text(getTranslated('pos_order', context)!))
        : Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.mapBg), fit: BoxFit.cover)),
            child: Card(
              margin: const EdgeInsets.all(Dimensions.marginSizeDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  orderProvider.onlyDigital
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const Divider(
                            //   thickness: .25,
                            // ),
                            ListTile(
                              title: Text(
                                getTranslated('shipping', context)!,
                              ),
                              enabled: false,
                              subtitle: Column(
                                children: [
                                  const SizedBox(
                                      height: Dimensions.marginSizeSmall),
                                  IconWithTextRowWidget(
                                    icon: Icons.person,
                                    text: '${orderProvider.orders?.name ?? 'بدون إسم'}',
                                    // text: '${orderProvider.orders!.shippingAddressData != null ? orderProvider.orders!.shippingAddressData!.contactPersonName : ''}',
                                  ),
                                  const SizedBox(
                                      height: Dimensions.marginSizeSmall),
                                  IconWithTextRowWidget(
                                    icon: Icons.call,
                                    text: '${orderProvider.orders?.phone ?? 'بدون رقم'}',
                                    // text: '${orderProvider.orders!.shippingAddressData != null ? orderProvider.orders!.shippingAddressData!.phone : ''}',
                                  ),
                                  const SizedBox(
                                      height: Dimensions.marginSizeSmall),
                                  IconWithTextRowWidget(
                                    icon: Icons.maps_home_work,
                                    text: 'الولاية ${int.tryParse(orderProvider.orders?.state ?? "")== null ? null : AlgerWilayas.state[int.parse(orderProvider.orders!.state!)-1]["ar_name"]}',
                                    // text: '${orderProvider.orders!.shippingAddressData != null ? orderProvider.orders!.shippingAddressData!.phone : ''}',
                                  ),
                                  // const SizedBox(
                                  //     height: Dimensions.marginSizeSmall),
                                  // Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.start,
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.start,
                                  //     children: [
                                  //       Icon(Icons.location_on,
                                  //           color: Provider.of<ThemeController>(
                                  //                       context,
                                  //                       listen: false)
                                  //                   .darkTheme
                                  //               ? Colors.white
                                  //               : Theme.of(context)
                                  //                   .primaryColor),
                                  //       const SizedBox(
                                  //           width: Dimensions.marginSizeSmall),
                                  //       Expanded(
                                  //           child: Padding(
                                  //               padding:
                                  //                   const EdgeInsets.symmetric(
                                  //                       vertical: 1),
                                  //               child: Text(
                                  //                   '${orderProvider.orders!.shippingAddressData != null ? orderProvider.orders!.shippingAddressData!.address : ''}',
                                  //                   maxLines: 3,
                                  //                   overflow:
                                  //                       TextOverflow.ellipsis,
                                  //                   style: titilliumRegular
                                  //                       .copyWith(
                                  //                           fontSize: Dimensions
                                  //                               .fontSizeDefault))))
                                  //     ]),
                                  // const SizedBox(
                                  //     height: Dimensions.paddingSizeSmall),
                                  // Row(children: [
                                  //   Expanded(
                                  //       child: IconWithTextRowWidget(
                                  //           imageIcon: Images.country,
                                  //           icon: Icons.location_city,
                                  //           text:
                                  //               '${orderProvider.orders!.shippingAddressData?.country != null ? orderProvider.orders!.shippingAddressData!.country : ''}')),
                                  //   Expanded(
                                  //       child: IconWithTextRowWidget(
                                  //     imageIcon: Images.city,
                                  //     icon: Icons.location_city,
                                  //     text:
                                  //         '${orderProvider.orders!.shippingAddressData != null ? orderProvider.orders!.shippingAddressData!.zip : ''}',
                                  //   ))
                                  // ]),
                                
                                ],
                              ),
                            ),
                            // const SizedBox(
                            //     height: Dimensions.marginSizeSmall),
                            // IconWithTextRowWidget(
                            //   icon: Icons.person,
                            //   text:
                            //       '${orderProvider.orders!.shippingAddressData != null ? orderProvider.orders!.shippingAddressData!.contactPersonName : ''}',
                            // ),
                            // const SizedBox(
                            //     height: Dimensions.marginSizeSmall),
                            // IconWithTextRowWidget(
                            //   icon: Icons.call,
                            //   text:
                            //       '${orderProvider.orders!.shippingAddressData != null ? orderProvider.orders!.shippingAddressData!.phone : ''}',
                            // ),
                            // const SizedBox(
                            //     height: Dimensions.marginSizeSmall),
                            // Row(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Icon(Icons.location_on,
                            //           color: Provider.of<ThemeController>(
                            //                       context,
                            //                       listen: false)
                            //                   .darkTheme
                            //               ? Colors.white
                            //               : Theme.of(context)
                            //                   .primaryColor
                            //                   .withOpacity(.30)),
                            //       const SizedBox(
                            //           width: Dimensions.marginSizeSmall),
                            //       Expanded(
                            //           child: Padding(
                            //               padding: const EdgeInsets.symmetric(
                            //                   vertical: 1),
                            //               child: Text(
                            //                   '${orderProvider.orders!.shippingAddressData != null ? orderProvider.orders!.shippingAddressData!.address : ''}',
                            //                   maxLines: 3,
                            //                   overflow: TextOverflow.ellipsis,
                            //                   style:
                            //                       titilliumRegular.copyWith(
                            //                           fontSize: Dimensions
                            //                               .fontSizeDefault))))
                            //     ]),
                            // const SizedBox(
                            //     height: Dimensions.paddingSizeSmall),
                            // Row(children: [
                            //   Expanded(
                            //       child: IconWithTextRowWidget(
                            //           imageIcon: Images.country,
                            //           icon: Icons.location_city,
                            //           text:
                            //               '${orderProvider.orders!.shippingAddressData?.country != null ? orderProvider.orders!.shippingAddressData!.country : ''}')),
                            //   Expanded(
                            //       child: IconWithTextRowWidget(
                            //     imageIcon: Images.city,
                            //     icon: Icons.location_city,
                            //     text:
                            //         '${orderProvider.orders!.shippingAddressData != null ? orderProvider.orders!.shippingAddressData!.zip : ''}',
                            //   ))
                            // ]),
                          ],
                        )
                      : const SizedBox(),
                  // const SizedBox(height: Dimensions.paddingSizeDefault),
                  orderProvider.orders!.billingAddressData != null
                      ? ListTile(
                          enabled: false,
                          title: Text(getTranslated('billing', context)!),
                          subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                    height: Dimensions.marginSizeSmall),
                                IconWithTextRowWidget(
                                    icon: Icons.person,
                                    text:
                                        '${orderProvider.orders!.billingAddressData != null ? orderProvider.orders!.billingAddressData!.contactPersonName : ''}'),
                                const SizedBox(
                                    height: Dimensions.marginSizeSmall),
                                IconWithTextRowWidget(
                                    icon: Icons.call,
                                    text:
                                        '${orderProvider.orders!.billingAddressData != null ? orderProvider.orders!.billingAddressData!.phone : ''}'),
                                const SizedBox(
                                    height: Dimensions.marginSizeSmall),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.location_on,
                                        color: Provider.of<ThemeController>(
                                                    context,
                                                    listen: false)
                                                .darkTheme
                                            ? Colors.white
                                            : Theme.of(context).primaryColor),
                                    const SizedBox(
                                        width: Dimensions.marginSizeSmall),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1),
                                      child: Text(
                                          ' ${orderProvider.orders!.billingAddressData != null ? orderProvider.orders!.billingAddressData!.address : ''}',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: titilliumRegular.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeDefault)),
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: Dimensions.paddingSizeSmall,
                                ),
                                Row(children: [
                                  Expanded(
                                      child: IconWithTextRowWidget(
                                          imageIcon: Images.country,
                                          icon: Icons.location_city,
                                          text:
                                              '${orderProvider.orders!.billingAddressData?.country != null ? orderProvider.orders!.billingAddressData!.country : ''}')),
                                  Expanded(
                                      child: IconWithTextRowWidget(
                                          imageIcon: Images.city,
                                          icon: Icons.location_city,
                                          text:
                                              '${orderProvider.orders!.billingAddressData != null ? orderProvider.orders!.billingAddressData!.zip : ''}'))
                                ]),
                              ]),
                        )
                      : const SizedBox(),
                ],
              ),
            ));
  }
}
