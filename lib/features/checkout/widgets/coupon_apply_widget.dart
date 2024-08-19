import 'package:flutter/material.dart';
import 'package:da3em/helper/price_converter.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/features/coupon/controllers/coupon_controller.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:da3em/features/checkout/widgets/coupon_bottom_sheet_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class CouponApplyWidget extends StatelessWidget {
  final TextEditingController couponController;
  final double orderAmount;
  const CouponApplyWidget(
      {super.key, required this.couponController, required this.orderAmount});

  @override
  Widget build(BuildContext context) {
    return Consumer<CouponController>(builder: (context, couponProvider, _) {
      return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
        ),
        child: (couponProvider.discount != null && couponProvider.discount != 0)
            ? Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeSmall),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        SizedBox(
                            height: 25,
                            width: 25,
                            child: Image.asset(Images.appliedCoupon)),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeExtraSmall),
                          child: Text(
                            couponProvider.couponCode,
                            style: textBold.copyWith(
                                fontSize: Dimensions.fontSizeLarge,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeExtraSmall),
                            child: Text(
                                '(-${PriceConverter.convertPrice(context, couponProvider.discount)} off)',
                                style: textMedium.copyWith(
                                    color: Theme.of(context).primaryColor)))
                      ]),
                      InkWell(
                          onTap: () => couponProvider.removeCoupon(),
                          child: Icon(Icons.clear,
                              color: Theme.of(context).colorScheme.error))
                    ]))
            : ListTile(
                onTap: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (c) =>
                        CouponBottomSheetWidget(orderAmount: orderAmount)),
                title: Text('Add Coupon',
                    style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall)),
                leading: Icon(
                  Iconsax.tag,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                trailing: Icon(
                  IconlyLight.plus,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
              ),
      );
    });
  }
}
