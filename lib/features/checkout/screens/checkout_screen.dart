import 'package:flutter/material.dart';
import 'package:da3em/features/address/controllers/address_controller.dart';
import 'package:da3em/features/address/screens/saved_address_list_screen.dart';
import 'package:da3em/features/address/screens/saved_billing_address_list_screen.dart';
import 'package:da3em/features/cart/domain/models/cart_model.dart';
import 'package:da3em/features/checkout/controllers/checkout_controller.dart';
import 'package:da3em/features/checkout/widgets/payment_method_bottom_sheet_widget.dart';
import 'package:da3em/features/offline_payment/screens/offline_payment_screen.dart';
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
import 'package:provider/provider.dart';
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
import 'package:da3em/features/checkout/widgets/CustomTextFielddd.dart';

import '../../../theme/controllers/theme_controller.dart';
import '../../product_details/widgets/form_checkout.dart';
import '../widgets/DropdownMenu_moh.dart';

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

  CheckoutScreen({super.key, required this.shippingMethodList,
    required this.cartList, this.fromProductDetails = false,
    required this.discount, required this.tax, required this.totalOrderAmount,
    required this.shippingFee, this.sellerId, this.onlyDigital = false, required this.quantity, required this.hasPhysical});

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
/*
    name.text = Provider.of<ProfileController>(context, listen: false).userInfoModel!.fName ?? "";
    phone.text = Provider.of<ProfileController>(context, listen: false).userInfoModel!.phone ?? "";
    if (name.text == phone.text) {
      phone.text = "";
      name.text = "";
    }*/
  }

  void setCheckoutToCod() {
    Provider.of<CheckoutController>(context, listen: false).setOfflineChecked('cod');
  }

  final name = TextEditingController();
  final phone = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  final promo = TextEditingController();
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
                  const ListTile(
                    title: Center( // Center the title text
                      child: Text( 'Delivery Information ',
                        textAlign: TextAlign.center, // Ensures text is centered
                      ),
                    ),                    enabled: false,
                  ),

                  CustomTextFielddd(
                    controller: phone,
                    label:getTranslated('enter_u_phone_nbr', context)?? 'Enter your phone number',
                    hintText: getTranslated('phone_nbr', context)??'Phone Number',
                    prefixIcon: const Icon(Icons.phone),
                    validator: (value) {
                      // Your validator code here
                    },
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    maxLength: 10,
                    onChanged: (value) {
                      // This will be called every time the text changes
                      print('Current input: $value');
                    },
                  ),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0), // Rounded corners
                    ),
                    child: DropdownMenu(
                      inputDecorationTheme: InputDecorationTheme(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.deepPurple, width: 1), // Deep purple border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.deepPurple, width: 1), // Deep purple border when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.deepPurple, width: 1), // Deep purple border when enabled
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.red, width: 1), // Red border for errors
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.red, width: 1), // Red border when focused with error
                        ),
                        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface), // Hint text style
                      ),
                      width: MediaQuery.of(context).size.width * 0.9, // Set dropdown width to 90% of screen
                      menuHeight: MediaQuery.of(context).size.height * 0.8,
                      hintText: "الولاية", // Hint text in Arabic
                      leadingIcon: const Icon(Iconsax.location), // Leading icon for dropdown
                      enableFilter: true,
                      menuStyle: MenuStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
                        padding: const WidgetStatePropertyAll(EdgeInsets.zero), // Reduce internal padding
                      ),
                      onSelected: (value) {
                        // Set the selected value to the text field or perform other actions
                        state.text = value.toString();
                        setState(() {}); // Refresh the UI to show the selected value
                      },
                      dropdownMenuEntries: AlgerWilayas.state.map((e) => DropdownMenuEntry(
                        style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 8, horizontal: 12))),
                        label: "${e['ar_name']}  - ${e['id']}",
                        value: e['id'],
                        labelWidget: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4), // Add margin to the entry
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Iconsax.location, color: Colors.deepPurple), // Icon for the state
                                  const SizedBox(width: 8),
                                  Text(
                                    "${e['ar_name']}", // Arabic name of the state
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(color: Provider.of<ThemeController>(context, listen: false).darkTheme
                                        ? Colors.white
                                        : Colors.black,
                                        fontWeight: FontWeight.bold), // Text styling
                                  ),
                                ],
                              ),
                              Text(
                                "${e['id']}", // ID of the state
                                style: TextStyle(color: Colors.grey.shade600), // Grey color for ID
                              ),
                            ],
                          ),
                        ),
                      )).toList(),
                    ),
                  ),


              /*
                  CustomTextField(
                   controller: promo,
                    label: 'Promo code',
                    hintText: 'Enter code here ',
                    prefixIcon: const Icon(Icons.offline_bolt),
                    validator: (value) {

                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),

              */
                  ListTile(
                    title: Text(getTranslated('order_summary', context) ?? '',
                        style: textMedium.copyWith(fontSize: 15, fontWeight: FontWeight.bold)),
                    subtitle: Consumer<CheckoutController>(builder: (context, checkoutController, child) {
                      _couponDiscount = Provider.of<CouponController>(context).discount ?? 0;

                      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        widget.quantity > 1 ? AmountWidget(title: '${getTranslated('sub_total', context)} ${' (${widget.quantity} ${getTranslated('items', context)}) '}', amount: PriceConverter.convertPrice(context, _order)) : AmountWidget(title: '${getTranslated('sub_total', context)} ${'(${widget.quantity} ${getTranslated('item', context)})'}', amount: PriceConverter.convertPrice(context, _order)),
                        // AmountWidget(
                        //     title: getTranslated('shipping_fee', context),
                        //     amount: PriceConverter.convertPrice(
                        //         context, widget.shippingFee)), //TODO RECHECK
                        AmountWidget(title: getTranslated('discount', context), amount: PriceConverter.convertPrice(context, widget.discount)),
                        AmountWidget(title: getTranslated('shipping_fee', context), amount: PriceConverter.convertPrice(context, widget.shippingFee)),
                        AmountWidget(title: getTranslated('coupon_voucher', context), amount: PriceConverter.convertPrice(context, _couponDiscount)),
                       // AmountWidget(title: getTranslated('tax', context), amount: PriceConverter.convertPrice(context, widget.tax)),
                        Divider(height: 5, color: Theme.of(context).hintColor),
                         AmountWidget(
                             title: getTranslated('total_payable', context),
                             amount: PriceConverter.convertPrice(
                                 context,
                                 (_order +
                                     widget.shippingFee -
                                    widget.discount -
                                     _couponDiscount! +
                                    widget.tax))), //TODO RECHEK THIS
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
                                  //           'select_a_shipping_address', context)0,
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
                                    //String phone =_order.phone;
                                    String couponCode = couponProvider.discount != null && couponProvider.discount != 0 ? couponProvider.couponCode : promo.text;
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
                                      orderProvider.digitalPaymentPlaceOrder(orderNote: orderNote, customerId:
                                      Provider.of<AuthController>(context, listen: false).isLoggedIn() ?
                                      profileProvider.userInfoModel?.id.toString() :
                                      Provider.of<AuthController>(context, listen: false).getGuestToken(),
                                          addressId: addressId,
                                          billingAddressId: billingAddressId,
                                          couponCode: promo.text,
                                          couponDiscount: couponCodeAmount,
                                          paymentMethod: orderProvider.selectedDigitalPaymentMethodName);
                                    } else if (orderProvider.codChecked && !widget.onlyDigital) {
                                      orderProvider.placeOrder(
                                        callback: _callback,
                                        addressID: addressId,

                                        name: name.text,
                                        phone: phone.text,
                                        state:state.text,

                                        couponCode: promo.text,
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
                                                  orderProvider.placeOrder(callback: _callback, wallet: true, addressID: addressId, couponCode: promo.text, couponAmount: couponCodeAmount, billingAddressId: billingAddressId, orderNote: orderNote);
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

/*
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
  List<ShippingMethodModel>? shippingMethodList;

  const CheckoutScreen({super.key,required this.shippingMethodList, required this.cartList, this.fromProductDetails = false,
    required this.discount, required this.tax, required this.totalOrderAmount, required this.shippingFee,
    this.sellerId, this.onlyDigital = false, required this.quantity, required this.hasPhysical});


  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();


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
    if(Provider.of<SplashController>(context, listen: false).configModel != null &&
        Provider.of<SplashController>(context, listen: false).configModel!.offlinePayment != null)
    {
      Provider.of<CheckoutController>(context, listen: false).getOfflinePaymentList();
    }

    if(Provider.of<AuthController>(context, listen: false).isLoggedIn()){
      Provider.of<CouponController>(context, listen: false).getAvailableCouponList();
    }

    _billingAddress = Provider.of<SplashController>(Get.context!, listen: false).configModel!.billingInputByCustomer == 1;
    Provider.of<CheckoutController>(context, listen: false).clearData();
  }

  @override
  Widget build(BuildContext context) {
    _order = widget.totalOrderAmount + widget.discount;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,

      bottomNavigationBar: Consumer<AddressController>(
        builder: (context, locationProvider,_) {
          return Consumer<CheckoutController>(
            builder: (context, orderProvider, child) {
              return Consumer<CouponController>(
                builder: (context, couponProvider, _) {
                  return Consumer<CartController>(
                    builder: (context, cartProvider,_) {
                      return Consumer<ProfileController>(
                        builder: (context, profileProvider,_) {
                          return orderProvider.isLoading ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center, children: [
                              SizedBox(width: 30,height: 30,child: CircularProgressIndicator())],):

                          Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                            child: CustomButton(onTap: () async {
                                if(orderProvider.addressIndex == null && widget.hasPhysical) {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const SavedAddressListScreen()));
                                  showCustomSnackBar(getTranslated('select_a_shipping_address', context), context, isToaster: true);

                                }else if((orderProvider.billingAddressIndex == null && !widget.hasPhysical && !orderProvider.sameAsBilling) || (orderProvider.billingAddressIndex == null && _billingAddress && !orderProvider.sameAsBilling)){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const SavedBillingAddressListScreen()));
                                  showCustomSnackBar(getTranslated('select_a_billing_address', context), context, isToaster: true);

                                }

                                // else if (orderProvider.isCheckCreateAccount && orderProvider.passwordController.text.isEmpty) {
                                //   showCustomSnackBar(getTranslated('password_is_required', context), context);
                                // } else if (orderProvider.isCheckCreateAccount && orderProvider.passwordController.text.length < 8){
                                //   showCustomSnackBar(getTranslated('minimum_password_is_8_character', context), context);
                                // } else if (orderProvider.isCheckCreateAccount && orderProvider.confirmPasswordController.text.isEmpty){
                                //   showCustomSnackBar(getTranslated('confirm_password_must_be_required', context), context);
                                // }else if (orderProvider.isCheckCreateAccount && (orderProvider.passwordController.text != orderProvider.confirmPasswordController.text)) {
                                //   showCustomSnackBar(getTranslated('confirm_password_not_matched', context), context);
                                // }

                                else {
                                  if(!orderProvider.isCheckCreateAccount || (orderProvider.isCheckCreateAccount && (passwordFormKey.currentState?.validate() ?? false))) {
                                    String orderNote = orderProvider.orderNoteController.text.trim();
                                    String couponCode = couponProvider.discount != null && couponProvider.discount != 0? couponProvider.couponCode : '';
                                    String couponCodeAmount = couponProvider.discount != null && couponProvider.discount != 0?
                                    couponProvider.discount.toString() : '0';

                                    // String addressId = !widget.onlyDigital? locationProvider.addressList![orderProvider.addressIndex!].id.toString():'';
                                    // String billingAddressId = (_billingAddress)? orderProvider.sameAsBilling? addressId:
                                    // locationProvider.addressList![orderProvider.billingAddressIndex!].id.toString() : '';

                                    String addressId =  orderProvider.addressIndex != null ?
                                    locationProvider.addressList![orderProvider.addressIndex!].id.toString() : '';

                                    String billingAddressId = (_billingAddress)?
                                    !orderProvider.sameAsBilling ?
                                    locationProvider.addressList![orderProvider.billingAddressIndex!].id.toString() : locationProvider.addressList![orderProvider.addressIndex!].id.toString() : '';



                                    if(orderProvider.paymentMethodIndex != -1){
                                      orderProvider.digitalPaymentPlaceOrder(
                                          orderNote: orderNote,
                                          customerId: Provider.of<AuthController>(context, listen: false).isLoggedIn()?
                                          profileProvider.userInfoModel?.id.toString() : Provider.of<AuthController>(context, listen: false).getGuestToken(),
                                          addressId: addressId,
                                          billingAddressId: billingAddressId,
                                          couponCode: couponCode,
                                          couponDiscount: couponCodeAmount,
                                          paymentMethod: orderProvider.selectedDigitalPaymentMethodName);

                                    }else if (orderProvider.codChecked && !widget.onlyDigital){
                                      orderProvider.placeOrder(callback: _callback,
                                          addressID : addressId,
                                          couponCode : couponCode,
                                          couponAmount : couponCodeAmount,
                                          billingAddressId : billingAddressId,
                                          orderNote : orderNote);}

                                    else if(orderProvider.offlineChecked){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                                          OfflinePaymentScreen(payableAmount: _order, callback: _callback)));}

                                    else if(orderProvider.walletChecked){
                                      showAnimatedDialog(context, WalletPaymentWidget(
                                          currentBalance: profileProvider.balance ?? 0,
                                          orderAmount: _order + widget.shippingFee - widget.discount - _couponDiscount! + widget.tax,
                                          onTap: (){if(profileProvider.balance! <
                                              (_order + widget.shippingFee - widget.discount - _couponDiscount! + widget.tax)){
                                            showCustomSnackBar(getTranslated('insufficient_balance', context), context, isToaster: true);
                                          }else{
                                            Navigator.pop(context);
                                            orderProvider.placeOrder(callback: _callback,wallet: true,
                                                addressID : addressId,
                                                couponCode : couponCode,
                                                couponAmount : couponCodeAmount,
                                                billingAddressId : billingAddressId,
                                                orderNote : orderNote);

                                          }}), dismissible: false, willFlip: true);
                                    }
                                    else {
                                      showModalBottomSheet(
                                        context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
                                        builder: (c) =>   PaymentMethodBottomSheetWidget(onlyDigital: widget.onlyDigital),
                                      );
                                    }
                                  }
                                }
                              },
                              buttonText: '${getTranslated('proceed', context)}',
                            ),
                          );
                        }
                      );
                    }
                  );
                }
              );
            }
          );
        }
      ),

      appBar: CustomAppBar(title: getTranslated('checkout', context)),
      body: Consumer<AuthController>(
        builder: (context, authProvider,_) {
          return Consumer<CheckoutController>(
            builder: (context, orderProvider,_) {
              return Column(children: [

                  Expanded(child: ListView(physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(0), children: [
                      Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                        child: ShippingDetailsWidget(hasPhysical: widget.hasPhysical, billingAddress: _billingAddress, passwordFormKey: passwordFormKey)),


                      if(Provider.of<AuthController>(context, listen: false).isLoggedIn())
                      Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                        child: CouponApplyWidget(couponController: _controller, orderAmount: _order)),



                       Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                        child: ChoosePaymentWidget(onlyDigital: widget.onlyDigital)),

                      Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,
                          Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault,Dimensions.paddingSizeSmall),
                        child: Text(getTranslated('order_summary', context)??'',
                          style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge))),



                      Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                        child: Consumer<CheckoutController>(
                          builder: (context, checkoutController, child) {
                             _couponDiscount = Provider.of<CouponController>(context).discount ?? 0;

                            return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              widget.quantity>1?
                              AmountWidget(title: '${getTranslated('sub_total', context)} ${' (${widget.quantity} ${getTranslated('items', context)}) '}',
                                  amount: PriceConverter.convertPrice(context, _order)):
                              AmountWidget(title: '${getTranslated('sub_total', context)} ${'(${widget.quantity} ${getTranslated('item', context)})'}',
                                  amount: PriceConverter.convertPrice(context, _order)),
                              AmountWidget(title: getTranslated('shipping_fee', context),
                                  amount: PriceConverter.convertPrice(context, widget.shippingFee)),
                              AmountWidget(title: getTranslated('discount', context),
                                  amount: PriceConverter.convertPrice(context, widget.discount)),
                              AmountWidget(title: getTranslated('coupon_voucher', context),
                                  amount: PriceConverter.convertPrice(context, _couponDiscount)),
                              AmountWidget(title: getTranslated('tax', context),
                                  amount: PriceConverter.convertPrice(context, widget.tax)),
                              Divider(height: 5, color: Theme.of(context).hintColor),
                              AmountWidget(title: getTranslated('total_payable', context),
                                  amount: PriceConverter.convertPrice(context,
                                  (_order + widget.shippingFee - widget.discount - _couponDiscount! + widget.tax))),
                            ]);})),


                      Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault,
                          Dimensions.paddingSizeDefault,Dimensions.paddingSizeDefault,0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(children: [
                              Text('${getTranslated('order_note', context)}',
                                style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge))]),
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          CustomTextFieldWidget(
                            hintText: getTranslated('enter_note', context),
                            inputType: TextInputType.multiline,
                            inputAction: TextInputAction.done,
                            maxLines: 3,
                            focusNode: _orderNoteNode,
                            controller: orderProvider.orderNoteController)])),
                    ]),
                  ),
                ],
              );
            }
          );
        }
      ),
    );
  }

  void _callback(bool isSuccess, String message, String orderID, bool createAccount) async {
    if(isSuccess) {
        Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);
        showAnimatedDialog(context, OrderPlaceDialogWidget(
          icon: Icons.check,
          title: getTranslated(createAccount ? 'order_placed_Account_Created' : 'order_placed', context),
          description: getTranslated('your_order_placed', context),
          isFailed: false,
        ), dismissible: false, willFlip: true);
    }else {
      showCustomSnackBar(message, context, isToaster: true);
    }
  }
}

*/