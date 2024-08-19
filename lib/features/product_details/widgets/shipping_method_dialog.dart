// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:da3em/features/product_details/domain/models/product_details_model.dart'
    as px;
import 'package:provider/provider.dart';

import 'package:da3em/common/basewidget/custom_button_widget.dart';
import 'package:da3em/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:da3em/features/cart/controllers/cart_controller.dart';
import 'package:da3em/features/cart/domain/models/cart_model.dart';
import 'package:da3em/features/product/domain/models/product_model.dart';
import 'package:da3em/features/shipping/domain/models/shipping_method_model.dart';
import 'package:da3em/helper/price_converter.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/utill/color_resources.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';

class ChooseShippingMethodDialog extends StatefulWidget {
  final List<ShippingMethodModel>? shippingMethodList;
  final CartModelBody cart;
  final List<ChoiceOptions> choices;
  final List<int>? variationIndexes;
  Function(BuildContext context, CartModel cart, double shippingCost,
      List<ShippingMethodModel>? shippingList) callback;

  ChooseShippingMethodDialog(this.shippingMethodList, this.cart, this.choices,
      this.variationIndexes, this.callback,
      {super.key});

  @override
  State<ChooseShippingMethodDialog> createState() =>
      _ChooseShippingMethodDialogState();
}

class _ChooseShippingMethodDialogState
    extends State<ChooseShippingMethodDialog> {
  int? selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == null) {
      showCustomSnackBar(
          getTranslated('select_shipping_method', context)!, context,
          isError: true, isToaster: true);
    } else {
      Provider.of<CartController>(context, listen: false)
          .addToCartAPI(
              widget.cart, context, widget.choices, widget.variationIndexes,
              buyNow: 1,
              shippingMethodExist: 1,
              shippingMethodId: widget.shippingMethodList![selectedIndex!].id)
          .then((value) {
        if (value.response!.statusCode == 200 &&
            value.response?.data['status'] == 1) {
          CartModel cart = CartModel.fromJson(value.response?.data['cart']);
          widget.callback(
              context,
              cart,
              double.tryParse(value.response?.data['cart_shipping_cost'])!,
              widget.shippingMethodList);
        } else {
          showCustomSnackBar(
              getTranslated(value.response?.data['message'], context)!, context,
              isError: true, isToaster: true);
        }
      });
    }
    return Consumer<CartController>(builder: (context, cartController, _) {
      return Dialog(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Images.logoWithNameImage, height: 35),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.2),
                child: LinearProgressIndicator(),
              ),
              SizedBox(
                height: 5,
              ),
              Text("We are processing\nyour order", //TODO translate

                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          )),
        ),
      );
    });
  }
}

class ShippingOptionDialog extends StatefulWidget {
  final List<ShippingMethodModel>? shippingMethodList;
  final CartModelBody cart;
  final List<ChoiceOptions> choices;
  final List<int>? variationIndexes;
  final px.ProductDetailsModel? product;

  Function(BuildContext context, CartModel cart, double shippingCost) callback;
  ShippingOptionDialog({
    this.product,
    Key? key,
    this.shippingMethodList,
    required this.cart,
    required this.choices,
    this.variationIndexes,
    required this.callback,
  }) : super(key: key);

  @override
  State<ShippingOptionDialog> createState() => _ShippingOptionDialogState();
}

class _ShippingOptionDialogState extends State<ShippingOptionDialog> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(builder: (context, cartController, _) {
      return Container(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          color: Theme.of(context).cardColor,
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const SizedBox(),
                Text(getTranslated('shipping_method', context)!,
                    style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeLarge)),
                Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        style: const ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop())),
              ]),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              Column(
                children: [
                  Row(children: [
                    Image.asset(
                      Images.shippingMethodIcon,
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Text(getTranslated('choose_shipping_method', context)!,
                        style: textMedium.copyWith(
                            fontSize: Dimensions.fontSizeDefault)),
                  ]),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                Dimensions.paddingSizeSmall),
                            border: Border.all(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(.25),
                                width: .5),
                            // color: Theme.of(context).primaryColor.withOpacity(.1)
                          ),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.shippingMethodList!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: Dimensions.paddingSizeSmall),
                                  child: InkWell(
                                      onTap: () {
                                        setState(() => selectedIndex = index);
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(children: [
                                            selectedIndex == index
                                                ? const Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green,
                                                  )
                                                : Icon(
                                                    Icons.circle_outlined,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                            const SizedBox(
                                                width: Dimensions
                                                    .paddingSizeSmall),
                                            Expanded(
                                              child: Text(
                                                  '${widget.shippingMethodList![index].title}'
                                                  ' (Duration ${widget.shippingMethodList![index].duration})'),
                                            ),
                                            const SizedBox(
                                                width: Dimensions
                                                    .paddingSizeSmall),
                                            Text(
                                                ' ${PriceConverter.convertPrice(context, widget.shippingMethodList![index].cost)}',
                                                style: textBold.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeLarge))
                                          ]))));
                            },
                          )),
                    ],
                  ),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  cartController.addToCartLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          buttonText:
                              getTranslated('proceed_to_checkout', context)!,
                          onTap: () {
                            if (selectedIndex == null) {
                              showCustomSnackBar(
                                  getTranslated(
                                      'select_shipping_method', context)!,
                                  context,
                                  isError: true,
                                  isToaster: true);
                            } else {
                              Provider.of<CartController>(context,
                                      listen: false)
                                  .addToCartAPI(widget.cart, context,
                                      widget.choices, widget.variationIndexes,
                                      buyNow: 1,
                                      shippingMethodExist: 1,
                                      shippingMethodId: widget
                                          .shippingMethodList![selectedIndex!]
                                          .id)
                                  .then((value) {
                                if (value.response!.statusCode == 200 &&
                                    value.response?.data['status'] == 1) {
                                  CartModel cart = CartModel.fromJson(
                                      value.response?.data['cart']);
                                  widget.callback(
                                      context,
                                      cart,
                                      double.tryParse(value.response
                                          ?.data['cart_shipping_cost'])!);
                                } else {
                                  showCustomSnackBar(
                                      getTranslated(
                                          value.response?.data['message'],
                                          context)!,
                                      context,
                                      isError: true,
                                      isToaster: true);
                                }
                              });
                            }
                          },
                        ),
                ],
              ),
            ]),
      );
    });
  }
}
