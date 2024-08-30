import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:da3em/features/address/controllers/address_controller.dart';
import 'package:da3em/features/cart/domain/models/cart_model.dart';
import 'package:da3em/features/checkout/controllers/checkout_controller.dart';
import 'package:da3em/features/offline_payment/screens/offline_payment_screen.dart';
import 'package:da3em/features/product_details/domain/models/product_details_model.dart' as px;
import 'package:da3em/features/product_details/widgets/shipping_method_dialog.dart';
import 'package:da3em/features/profile/controllers/profile_contrroller.dart';
import 'package:da3em/features/shipping/controllers/shipping_controller.dart';
import 'package:da3em/features/shipping/domain/models/shipping_method_model.dart';
import 'package:da3em/helper/price_converter.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/main.dart';
import 'package:da3em/features/auth/controllers/auth_controller.dart';
import 'package:da3em/features/cart/controllers/cart_controller.dart';
import 'package:da3em/features/coupon/controllers/coupon_controller.dart';
import 'package:da3em/features/splash/controllers/splash_controller.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/common/basewidget/amount_widget.dart';
import 'package:da3em/common/basewidget/animated_custom_dialog_widget.dart';
import 'package:da3em/common/basewidget/custom_app_bar_widget.dart';
import 'package:da3em/common/basewidget/custom_button_widget.dart';
import 'package:da3em/features/checkout/widgets/order_place_dialog_widget.dart';
import 'package:da3em/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:da3em/common/basewidget/custom_textfield_widget.dart';
import 'package:da3em/features/checkout/widgets/choose_payment_widget.dart';
import 'package:da3em/features/checkout/widgets/coupon_apply_widget.dart';
import 'package:da3em/features/checkout/widgets/shipping_details_widget.dart';
import 'package:da3em/features/checkout/widgets/wallet_payment_widget.dart';
import 'package:da3em/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../product_details/widgets/form_checkout.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartModel> cartList;
  final bool fromProductDetails;
  final double totalOrderAmount;
  final double shippingFee;
  final double discount;
  final double tax;
  final int? sellerId;
  final bool onlyDigital;
  final bool hasPhysical;
  final int quantity;
  // final List<px.ProductDetailsModel> choices;
  List<ShippingMethodModel>? shippingMethodList;

  CheckoutScreen({super.key, required this.shippingMethodList, required this.cartList, this.fromProductDetails = false, required this.discount, required this.tax, required this.totalOrderAmount, required this.shippingFee, this.sellerId, this.onlyDigital = false, required this.quantity, required this.hasPhysical});

  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _controller = TextEditingController();

  final FocusNode _orderNoteNode = FocusNode();
  double _order = 0;
  late bool _billingAddress;
  double? _couponDiscount;

  @override
  void initState() {
    super.initState();
    Provider.of<AddressController>(context, listen: false).getAddressList();
    Provider.of<CouponController>(context, listen: false).removePrevCouponData();
    Provider.of<CartController>(context, listen: false).getCartData(context);
    Provider.of<CheckoutController>(context, listen: false).resetPaymentMethod();
    Provider.of<ShippingController>(context, listen: false).getChosenShippingMethod(context);
    if (Provider.of<SplashController>(context, listen: false).configModel != null && Provider.of<SplashController>(context, listen: false).configModel!.offlinePayment != null) {
      Provider.of<CheckoutController>(context, listen: false).getOfflinePaymentList();
    }

    if (Provider.of<AuthController>(context, listen: false).isLoggedIn()) {
      Provider.of<CouponController>(context, listen: false).getAvailableCouponList();
    }

    _billingAddress = Provider.of<SplashController>(Get.context!, listen: false).configModel!.billingInputByCustomer == 1;
    Provider.of<CheckoutController>(context, listen: false).clearData();
    print('===OnlyDigital===>>${widget.onlyDigital}');

    // checkoutProvider.setOfflineChecked('cod')
    setCheckoutToCod();

    name.text = Provider.of<ProfileController>(context, listen: false).userInfoModel!.fName ?? "";
    phone.text = Provider.of<ProfileController>(context, listen: false).userInfoModel!.phone ?? "";
    if (name.text == phone.text) {
      phone.text = "";
      name.text = "";
    }
  }

  void setCheckoutToCod() {
    Provider.of<CheckoutController>(context, listen: false).setOfflineChecked('cod');
  }

  final name = TextEditingController();
  final phone = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _order = widget.totalOrderAmount + widget.discount;

    // return Scaffold(
    //   appBar: CustomAppBar(title: getTranslated('checkout', context)),
    //   body: FormCheckout());
    return Consumer<AuthController>(builder: (context, authProvider, _) {
      return Consumer<CheckoutController>(builder: (context, orderProvider, _) {
        return Form(
          key: formKey,
          child: Container(
            // handle keyboard view
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomAppBar(title: getTranslated('checkout', context)),
                  ListTile(
                    leading: Icon(Iconsax.location),
                    title: Text("بيانات التوصيل"),
                    enabled: false,
                  ),
                  CustomTextField(
                    controller: phone,
                    label: 'رقم الهاتف',
                    hintText: 'ادخل رقم الهاتف الذي سيتصل به عامل التوصيل',
                    prefixIcon: const Icon(Icons.phone),
                    validator: (value) {
                      if (value == '') {
                        return 'اردخل رقم هاتفك رجاءا';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownMenu(
                      inputDecorationTheme: InputDecorationTheme(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                      ),
                      width: double.infinity,
                      hintText: "الولاية",
                      leadingIcon: const Icon(Iconsax.location),
                      enableFilter: true,
                      menuStyle: MenuStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        // fixedSize: WidgetStatePropertyAll(
                        //     Size(MediaQuery.of(context).size.width * 0.15, 300)),
                        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 3)),
                      ),
                      onSelected: (value) {
                        state.text = value.toString();
                        setState(() {});
                      },
                      dropdownMenuEntries: AlgerWilayas.state
                          .map((e) => DropdownMenuEntry(
                              style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.all(1))),
                              value: e['id'],
                              label: "${e['ar_name']} ${e['id']}",
                              labelWidget: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${e['ar_name']} ${e['id']}",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                              leadingIcon: const CircleAvatar(child: Icon(Iconsax.location))))
                          .toList(),
                    ),
                  ),
                  ListTile(
                    title: Text(getTranslated('order_summary', context) ?? '', style: textMedium.copyWith(fontSize: 15, fontWeight: FontWeight.bold)),
                    subtitle: Consumer<CheckoutController>(builder: (context, checkoutController, child) {
                      _couponDiscount = Provider.of<CouponController>(context).discount ?? 0;
              
                      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        widget.quantity > 1 ? AmountWidget(title: '${getTranslated('sub_total', context)} ${' (${widget.quantity} ${getTranslated('items', context)}) '}', amount: PriceConverter.convertPrice(context, _order)) : AmountWidget(title: '${getTranslated('sub_total', context)} ${'(${widget.quantity} ${getTranslated('item', context)})'}', amount: PriceConverter.convertPrice(context, _order)),
                        // AmountWidget(
                        //     title: getTranslated('shipping_fee', context),
                        //     amount: PriceConverter.convertPrice(
                        //         context, widget.shippingFee)), //TODO RECHECK
                        AmountWidget(title: getTranslated('discount', context), amount: PriceConverter.convertPrice(context, widget.discount)),
                        AmountWidget(title: getTranslated('coupon_voucher', context), amount: PriceConverter.convertPrice(context, _couponDiscount)),
                        AmountWidget(title: getTranslated('tax', context), amount: PriceConverter.convertPrice(context, widget.tax)),
                        Divider(height: 5, color: Theme.of(context).hintColor),
                        // AmountWidget(
                        //     title: getTranslated('total_payable', context),
                        //     amount: PriceConverter.convertPrice(
                        //         context,
                        //         (_order +
                        //             widget.shippingFee -
                        //             widget.discount -
                        //             _couponDiscount! +
                        //             widget.tax))), //TODO RECHEK THIS
                      ]);
                    }),
                  ),
                  Consumer<AddressController>(builder: (context, locationProvider, _) {
                    return Consumer<CheckoutController>(builder: (context, orderProvider, child) {
                      return Consumer<CouponController>(builder: (context, couponProvider, _) {
                        return Consumer<CartController>(builder: (context, cartProvider, _) {
                          return Consumer<ProfileController>(builder: (context, profileProvider, _) {
                            return orderProvider.isLoading
                                ? const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 30, height: 30, child: CircularProgressIndicator())
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                                    child: CustomButton(
                                      onTap: () async {
                                        if (!formKey.currentState!.validate()) {
                                          showCustomSnackBar('الرجاء ادخال البيانات', context);
                                          return;
                                        }
                                        if (state.text.isEmpty) {
                                          showCustomSnackBar('الرجاء اختيار الولاية', context);
                                          return;
                                        }
                                        // if (orderProvider.addressIndex == null &&
                                        //     widget.hasPhysical) {
                                        //   log("message");
                                        //   showCustomSnackBar(
                                        //       getTranslated(
                                        //           'select_a_shipping_address', context),
                                        //       context,
                                        //       isToaster: true);
                                        // } else
                                        // if ((orderProvider.billingAddressIndex == null && !widget.hasPhysical && !orderProvider.sameAsBilling) || (orderProvider.billingAddressIndex == null && _billingAddress && !orderProvider.sameAsBilling)) {
                                        //   showCustomSnackBar(getTranslated('select_a_billing_address', context), context, isToaster: true);
                                        // } else if (orderProvider.isCheckCreateAccount && orderProvider.passwordController.text.isEmpty) {
                                        //   showCustomSnackBar(getTranslated('password_is_required', context), context);
                                        // } else if (orderProvider.isCheckCreateAccount && orderProvider.passwordController.text.length < 8) {
                                        //   showCustomSnackBar(getTranslated('minimum_password_is_8_character', context), context);
                                        // } else if (orderProvider.isCheckCreateAccount && orderProvider.confirmPasswordController.text.isEmpty) {
                                        //   showCustomSnackBar(getTranslated('confirm_password_must_be_required', context), context);
                                        // } else if (orderProvider.isCheckCreateAccount && (orderProvider.passwordController.text != orderProvider.confirmPasswordController.text)) {
                                        //   showCustomSnackBar(getTranslated('confirm_password_not_matched', context), context);
                                        // } else 
                                        if (true)
                                        {
                                          String orderNote = orderProvider.orderNoteController.text.trim();
                                          String couponCode = couponProvider.discount != null && couponProvider.discount != 0 ? couponProvider.couponCode : '';
                                          String couponCodeAmount = couponProvider.discount != null && couponProvider.discount != 0 ? couponProvider.discount.toString() : '0';
              
                                          // String addressId = !widget.onlyDigital? locationProvider.addressList![orderProvider.addressIndex!].id.toString():'';
                                          // String billingAddressId = (_billingAddress)? orderProvider.sameAsBilling? addressId:
                                          // locationProvider.addressList![orderProvider.billingAddressIndex!].id.toString() : '';
              
                                          String addressId = orderProvider.addressIndex != null ? locationProvider.addressList![orderProvider.addressIndex!].id.toString() : '';
              
                                          String billingAddressId;
                                          if (_billingAddress && orderProvider.addressIndex != null) {
                                            if (!orderProvider.sameAsBilling) {
                                              billingAddressId = locationProvider.addressList![orderProvider.billingAddressIndex!].id.toString();
                                            } else {
                                              billingAddressId = locationProvider.addressList![orderProvider.addressIndex!].id.toString();
                                            }
                                          } else {
                                            billingAddressId = '';
                                          }
              
                                          if (orderProvider.paymentMethodIndex != -1) {
                                            orderProvider.digitalPaymentPlaceOrder(orderNote: orderNote, customerId: Provider.of<AuthController>(context, listen: false).isLoggedIn() ? profileProvider.userInfoModel?.id.toString() : Provider.of<AuthController>(context, listen: false).getGuestToken(), addressId: addressId, billingAddressId: billingAddressId, couponCode: couponCode, couponDiscount: couponCodeAmount, paymentMethod: orderProvider.selectedDigitalPaymentMethodName);
                                          } else if (orderProvider.codChecked && !widget.onlyDigital) {
                                            orderProvider.placeOrder(
                                              callback: _callback,
                                              addressID: addressId,
              
                                              name: name.text,
                                              phone: phone.text,
                                              state:state.text,
              
                                              couponCode: couponCode,
                                              couponAmount: couponCodeAmount,
                                              billingAddressId: billingAddressId,
                                              orderNote: orderNote,
                                            );
                                          } else if (orderProvider.offlineChecked) {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => OfflinePaymentScreen(payableAmount: _order, callback: _callback)));
                                          } else if (orderProvider.walletChecked) {
                                            showAnimatedDialog(
                                                context,
                                                WalletPaymentWidget(
                                                    currentBalance: profileProvider.balance ?? 0,
                                                    orderAmount: _order + widget.shippingFee - widget.discount - _couponDiscount! + widget.tax,
                                                    onTap: () {
                                                      if (profileProvider.balance! < (_order + widget.shippingFee - widget.discount - _couponDiscount! + widget.tax)) {
                                                        showCustomSnackBar(getTranslated('insufficient_balance', context), context, isToaster: true);
                                                      } else {
                                                        Navigator.pop(context);
                                                        orderProvider.placeOrder(callback: _callback, wallet: true, addressID: addressId, couponCode: couponCode, couponAmount: couponCodeAmount, billingAddressId: billingAddressId, orderNote: orderNote);
                                                      }
                                                    }),
                                                dismissible: false,
                                                willFlip: true);
                                          } else {
                                            showCustomSnackBar('${getTranslated('select_payment_method', context)}', context);
                                          }
                                        }
                                      },
                                      buttonText: '${getTranslated('proceed', context)}',
                                    ),
                                  );
                          });
                        });
                      });
                    });
                  })
                ],
              ),
            ),
          ),
        );
      });
    });
  }

  void _callback(bool isSuccess, String message, String orderID, bool createAccount) async {
    if (isSuccess) {
      Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);
      showAnimatedDialog(
          context,
          OrderPlaceDialogWidget(
            icon: Icons.check,
            title: getTranslated(createAccount ? 'order_placed_Account_Created' : 'order_placed', context),
            description: getTranslated('your_order_placed', context),
            isFailed: false,
          ),
          dismissible: false,
          willFlip: true);
    } else {
      showCustomSnackBar(message, context, isToaster: true);
    }
  }
}
