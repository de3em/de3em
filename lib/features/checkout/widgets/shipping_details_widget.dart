import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:da3em/features/address/controllers/address_controller.dart';
import 'package:da3em/features/auth/controllers/auth_controller.dart';
import 'package:da3em/features/checkout/controllers/checkout_controller.dart';
import 'package:da3em/features/checkout/widgets/create_account_widget.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:da3em/features/address/screens/saved_address_list_screen.dart';
import 'package:da3em/features/address/screens/saved_billing_address_list_screen.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class ShippingDetailsWidget extends StatefulWidget {
  final bool hasPhysical;
  final bool billingAddress;
  const ShippingDetailsWidget(
      {super.key, required this.hasPhysical, required this.billingAddress});

  @override
  State<ShippingDetailsWidget> createState() => _ShippingDetailsWidgetState();
}

class _ShippingDetailsWidgetState extends State<ShippingDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    bool isGuestMode =
        !Provider.of<AuthController>(context, listen: false).isLoggedIn();
    print('====hasPhosical====>>${widget.hasPhysical}');
    return Consumer<CheckoutController>(
        builder: (context, shippingProvider, _) {
      shippingProvider.setSameAsBilling();
      // if (shippingProvider.sameAsBilling && !widget.hasPhysical) {
      //   shippingProvider.setSameAsBilling();
      // }
      return Consumer<AddressController>(
          builder: (context, locationProvider, _) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          widget.hasPhysical
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.paddingSizeDefault),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              SizedBox(
                                  width: 18,
                                  child: Image.asset(Images.deliveryTo)),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Shipping address', //TODO translate
                                  style: textMedium.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //     (shippingProvider.addressIndex == null ||
                                //             locationProvider
                                //                 .addressList!.isEmpty)
                                //         ? '${getTranslated('address_type', context)}'
                                //         : locationProvider
                                //             .addressList![shippingProvider
                                //                 .addressIndex!]
                                //             .addressType!
                                //             .capitalize(),
                                //     style: textRegular.copyWith(
                                //         fontSize: Dimensions.fontSizeDefault),
                                //     maxLines: 3,
                                //     overflow: TextOverflow.fade),
                                // const Divider(thickness: .125),

                                (shippingProvider.addressIndex == null ||
                                        locationProvider.addressList!.isEmpty)
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              getTranslated('add_your_address',
                                                      context) ??
                                                  '',
                                              style: titilliumRegular.copyWith(
                                                  fontSize:
                                                      Dimensions.fontSizeSmall),
                                              maxLines: 3,
                                              overflow: TextOverflow.fade),
                                          InkWell(
                                            onTap: () => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        const SavedAddressListScreen())),
                                            child: SizedBox(
                                                width: 20,
                                                child: Icon(
                                                    IconlyLight.arrow_right,
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      IconlyLight.user,
                                                      size: 15,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                        "${locationProvider.addressList![shippingProvider.addressIndex!].contactPersonName} ${locationProvider.addressList![shippingProvider.addressIndex!].phone}"),
                                                  ],
                                                ),
                                                // Text(locationProvider
                                                //         .addressList![
                                                //             shippingProvider
                                                //                 .addressIndex!]
                                                //         .contactPersonName ??
                                                //     ''),

                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      IconlyLight.location,
                                                      size: 15,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "${locationProvider.addressList![shippingProvider.addressIndex!].address} ${locationProvider.addressList![shippingProvider.addressIndex!].addressType}"),
                                                        Text(
                                                            "${locationProvider.addressList![shippingProvider.addressIndex!].country} ,${locationProvider.addressList![shippingProvider.addressIndex!].city},${locationProvider.addressList![shippingProvider.addressIndex!].zip}"),
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                                // Text(locationProvider
                                                //         .addressList![
                                                //             shippingProvider
                                                //                 .addressIndex!]
                                                //         .country ??
                                                //     '')

                                                // AddressInfoItem(
                                                //     icon: Images.user,
                                                //     title: locationProvider
                                                //             .addressList![
                                                //                 shippingProvider
                                                //                     .addressIndex!]
                                                //             .contactPersonName ??
                                                //         ''),
                                                // AddressInfoItem(
                                                //     icon: Images.callIcon,
                                                //     title: locationProvider
                                                //             .addressList![
                                                //                 shippingProvider
                                                //                     .addressIndex!]
                                                //             .phone ??
                                                //         ''),
                                                // AddressInfoItem(
                                                //     icon: Images.address,
                                                //     title: locationProvider
                                                //             .addressList![
                                                //                 shippingProvider
                                                //                     .addressIndex!]
                                                //             .address ??
                                                //         ''),
                                              ]),
                                          InkWell(
                                            onTap: () => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        const SavedAddressListScreen())),
                                            child: SizedBox(
                                                width: 20,
                                                child: Icon(
                                                    IconlyLight.arrow_right,
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                          ),
                                        ],
                                      )
                              ]),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 8),
                        //   child: Divider(),
                        // ),
                        // const SizedBox(
                        //   height: Dimensions.paddingSizeDefault,
                        // ),
                        // Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //           (shippingProvider.addressIndex == null ||
                        //                   locationProvider
                        //                       .addressList!.isEmpty)
                        //               ? '${getTranslated('address_type', context)}'
                        //               : locationProvider
                        //                   .addressList![
                        //                       shippingProvider.addressIndex!]
                        //                   .addressType!
                        //                   .capitalize(),
                        //           style: textRegular.copyWith(
                        //               fontSize: Dimensions.fontSizeDefault),
                        //           maxLines: 3,
                        //           overflow: TextOverflow.fade),
                        //       const Divider(thickness: .125),
                        //       (shippingProvider.addressIndex == null ||
                        //               locationProvider.addressList!.isEmpty)
                        //           ? Text(
                        //               getTranslated(
                        //                       'add_your_address', context) ??
                        //                   '',
                        //               style: titilliumRegular.copyWith(
                        //                   fontSize: Dimensions.fontSizeSmall),
                        //               maxLines: 3,
                        //               overflow: TextOverflow.fade)
                        //           : Column(
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.start,
                        //               children: [
                        //                   Text(
                        //                       "${locationProvider.addressList![shippingProvider.addressIndex!].phone} + ${locationProvider.addressList![shippingProvider.addressIndex!].contactPersonName}"),
                        //                   // Text(locationProvider
                        //                   //         .addressList![
                        //                   //             shippingProvider
                        //                   //                 .addressIndex!]
                        //                   //         .contactPersonName ??
                        //                   //     ''),
                        //                   Text(locationProvider
                        //                           .addressList![
                        //                               shippingProvider
                        //                                   .addressIndex!]
                        //                           .address ??
                        //                       ''),
                        //                   Text(locationProvider
                        //                           .addressList![
                        //                               shippingProvider
                        //                                   .addressIndex!]
                        //                           .city ??
                        //                       ''),
                        //                   Text(locationProvider
                        //                           .addressList![
                        //                               shippingProvider
                        //                                   .addressIndex!]
                        //                           .country ??
                        //                       '')

                        //                   // AddressInfoItem(
                        //                   //     icon: Images.user,
                        //                   //     title: locationProvider
                        //                   //             .addressList![
                        //                   //                 shippingProvider
                        //                   //                     .addressIndex!]
                        //                   //             .contactPersonName ??
                        //                   //         ''),
                        //                   // AddressInfoItem(
                        //                   //     icon: Images.callIcon,
                        //                   //     title: locationProvider
                        //                   //             .addressList![
                        //                   //                 shippingProvider
                        //                   //                     .addressIndex!]
                        //                   //             .phone ??
                        //                   //         ''),
                        //                   // AddressInfoItem(
                        //                   //     icon: Images.address,
                        //                   //     title: locationProvider
                        //                   //             .addressList![
                        //                   //                 shippingProvider
                        //                   //                     .addressIndex!]
                        //                   //             .address ??
                        //                   //         ''),
                        //                 ])
                        //     ]),
                      ]))
              : const SizedBox(),

          isGuestMode ? const CreateAccountWidget() : const SizedBox(),

          // if (widget.hasPhysical && widget.billingAddress)
          //   Padding(
          //     padding: EdgeInsets.only(
          //         bottom:
          //             widget.hasPhysical ? Dimensions.paddingSizeSmall : 0),
          //     child: InkWell(
          //       highlightColor: Colors.transparent,
          //       focusColor: Colors.transparent,
          //       splashColor: Colors.transparent,
          //       onTap: () => shippingProvider.setSameAsBilling(),
          //       child:
          //           Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          //         SizedBox(
          //             width: 20,
          //             height: 20,
          //             child: Container(
          //                 alignment: Alignment.center,
          //                 decoration: BoxDecoration(
          //                     border: Border.all(
          //                         color: Theme.of(context)
          //                             .primaryColor
          //                             .withOpacity(.75),
          //                         width: 1.5),
          //                     borderRadius: BorderRadius.circular(6)),
          //                 child: Icon(CupertinoIcons.checkmark_alt,
          //                     size: 15,
          //                     color: shippingProvider.sameAsBilling
          //                         ? Theme.of(context)
          //                             .primaryColor
          //                             .withOpacity(.75)
          //                         : Colors.transparent))),
          //         Padding(
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: Dimensions.paddingSizeSmall),
          //             child: Text(getTranslated('same_as_delivery', context)!,
          //                 style: textRegular.copyWith(
          //                     fontSize: Dimensions.fontSizeDefault)))
          //       ]),
          //     ),
          //   ),
          // if (widget.billingAddress && !shippingProvider.sameAsBilling)
          //   Card(
          //       child: Container(
          //     padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          //     decoration: BoxDecoration(
          //         borderRadius:
          //             BorderRadius.circular(Dimensions.paddingSizeDefault),
          //         color: Theme.of(context).cardColor),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Expanded(
          //                   child: Row(children: [
          //                 SizedBox(
          //                     width: 18,
          //                     child: Image.asset(Images.billingTo)),
          //                 Padding(
          //                     padding: const EdgeInsets.symmetric(
          //                         horizontal:
          //                             Dimensions.paddingSizeExtraSmall),
          //                     child: Text(
          //                         '${getTranslated('billing_to', context)}',
          //                         style: textMedium.copyWith(
          //                             fontSize: Dimensions.fontSizeLarge)))
          //               ])),
          //               InkWell(
          //                 onTap: () => Navigator.of(context).push(
          //                     MaterialPageRoute(
          //                         builder: (BuildContext context) =>
          //                             const SavedBillingAddressListScreen())),
          //                 child: SizedBox(
          //                     width: 20,
          //                     child: Image.asset(
          //                       Images.edit,
          //                       scale: 3,
          //                       color: Theme.of(context).primaryColor,
          //                     )),
          //               ),
          //             ]),
          //         const SizedBox(
          //           height: Dimensions.paddingSizeDefault,
          //         ),
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               (shippingProvider.billingAddressIndex == null ||
          //                       locationProvider.addressList == null)
          //                   ? '${getTranslated('address_type', context)}'
          //                   : locationProvider
          //                       .addressList![
          //                           shippingProvider.billingAddressIndex!]
          //                       .addressType!
          //                       .capitalize(),
          //               style: textRegular.copyWith(
          //                   fontSize: Dimensions.fontSizeDefault),
          //               maxLines: 1,
          //               overflow: TextOverflow.fade,
          //             ),
          //             const Divider(thickness: .125),
          //             (shippingProvider.billingAddressIndex == null ||
          //                     locationProvider.addressList == null)
          //                 ? Text(
          //                     getTranslated('add_your_address', context)!,
          //                     style: titilliumRegular.copyWith(
          //                         fontSize: Dimensions.fontSizeSmall),
          //                     maxLines: 3,
          //                     overflow: TextOverflow.fade,
          //                   )
          //                 : Column(children: [
          //                     AddressInfoItem(
          //                         icon: Images.user,
          //                         title: locationProvider
          //                                 .addressList?[shippingProvider
          //                                     .billingAddressIndex!]
          //                                 .contactPersonName ??
          //                             ''),
          //                     AddressInfoItem(
          //                         icon: Images.callIcon,
          //                         title: locationProvider
          //                                 .addressList?[shippingProvider
          //                                     .billingAddressIndex!]
          //                                 .phone ??
          //                             ''),
          //                     AddressInfoItem(
          //                         icon: Images.address,
          //                         title: locationProvider
          //                                 .addressList?[shippingProvider
          //                                     .billingAddressIndex!]
          //                                 .address ??
          //                             ''),
          //                   ]),
          //           ],
          //         ),
          //       ],
          //     ),
          //   )),
          // if (widget.billingAddress && shippingProvider.sameAsBilling)
          //   Card(
          //       child: Container(
          //     padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          //     decoration: BoxDecoration(
          //         borderRadius:
          //             BorderRadius.circular(Dimensions.paddingSizeDefault),
          //         color: Theme.of(context).cardColor),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Expanded(
          //                   child: Row(children: [
          //                 SizedBox(
          //                     width: 18,
          //                     child: Image.asset(Images.billingTo)),
          //                 Padding(
          //                     padding: const EdgeInsets.symmetric(
          //                         horizontal:
          //                             Dimensions.paddingSizeExtraSmall),
          //                     child: Row(
          //                       children: [
          //                         Text(
          //                             '${getTranslated('billing_to', context)}',
          //                             style: textMedium.copyWith(
          //                                 fontSize:
          //                                     Dimensions.fontSizeLarge)),
          //                         const SizedBox(
          //                             width: Dimensions.paddingSizeSmall),
          //                         Text(
          //                             '(${getTranslated("same_as_delivery", context)})',
          //                             style: textMedium.copyWith(
          //                                 fontSize:
          //                                     Dimensions.fontSizeDefault,
          //                                 color: Theme.of(context)
          //                                     .hintColor
          //                                     .withOpacity(.75))),
          //                       ],
          //                     ))
          //               ])),
          //             ]),
          //       ],
          //     ),
          //   )),
        ]);
      });
    });
  }
}

class AddressInfoItem extends StatelessWidget {
  final String? icon;
  final String? title;
  const AddressInfoItem({super.key, this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeExtraSmall),
      child: Row(children: [
        SizedBox(width: 18, child: Image.asset(icon!)),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeSmall),
                child: Text(title ?? '',
                    style: textRegular.copyWith(),
                    maxLines: 2,
                    overflow: TextOverflow.fade)))
      ]),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
