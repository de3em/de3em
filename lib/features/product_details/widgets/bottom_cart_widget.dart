import 'package:flutter/material.dart';
import 'package:da3em/features/product_details/domain/models/product_details_model.dart';
import 'package:da3em/features/product_details/widgets/cart_bottom_sheet_widget.dart';
import 'package:da3em/features/splash/controllers/splash_controller.dart';
import 'package:da3em/helper/responsive_helper.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/features/cart/controllers/cart_controller.dart';
import 'package:da3em/theme/controllers/theme_controller.dart';
import 'package:da3em/utill/color_resources.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:da3em/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:da3em/features/cart/screens/cart_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class BottomCartWidget extends StatefulWidget {
  final ProductDetailsModel? product;
  const BottomCartWidget({super.key, required this.product});

  @override
  State<BottomCartWidget> createState() => _BottomCartWidgetState();
}

class _BottomCartWidgetState extends State<BottomCartWidget> {
  bool vacationIsOn = false;
  bool temporaryClose = false;

  @override
  void initState() {
    super.initState();

    final today = DateTime.now();

    if (widget.product != null && widget.product!.addedBy == 'admin') {
      DateTime vacationDate =
          Provider.of<SplashController>(context, listen: false)
                      .configModel
                      ?.inhouseVacationAdd
                      ?.vacationEndDate !=
                  null
              ? DateTime.parse(
                  Provider.of<SplashController>(context, listen: false)
                      .configModel!
                      .inhouseVacationAdd!
                      .vacationEndDate!)
              : DateTime.now();

      DateTime vacationStartDate =
          Provider.of<SplashController>(context, listen: false)
                      .configModel
                      ?.inhouseVacationAdd
                      ?.vacationStartDate !=
                  null
              ? DateTime.parse(
                  Provider.of<SplashController>(context, listen: false)
                      .configModel!
                      .inhouseVacationAdd!
                      .vacationStartDate!)
              : DateTime.now();

      final difference = vacationDate.difference(today).inDays;
      final startDate = vacationStartDate.difference(today).inDays;

      if (difference >= 0 &&
          (Provider.of<SplashController>(context, listen: false)
                  .configModel
                  ?.inhouseVacationAdd
                  ?.status ==
              1) &&
          startDate <= 0) {
        vacationIsOn = true;
      } else {
        vacationIsOn = false;
      }
    } else if (widget.product != null &&
        widget.product!.seller != null &&
        widget.product!.seller!.shop!.vacationEndDate != null) {
      DateTime vacationDate =
          DateTime.parse(widget.product!.seller!.shop!.vacationEndDate!);
      DateTime vacationStartDate =
          DateTime.parse(widget.product!.seller!.shop!.vacationStartDate!);
      final difference = vacationDate.difference(today).inDays;
      final startDate = vacationStartDate.difference(today).inDays;

      if (difference >= 0 &&
          widget.product!.seller!.shop!.vacationStatus! &&
          startDate <= 0) {
        vacationIsOn = true;
      } else {
        vacationIsOn = false;
      }
    }

    if (widget.product != null && widget.product!.addedBy == 'admin') {
      if (widget.product != null &&
          (Provider.of<SplashController>(context, listen: false)
                  .configModel
                  ?.inhouseTemporaryClose
                  ?.status ==
              1)) {
        temporaryClose = true;
      } else {
        temporaryClose = false;
      }
    } else {
      if (widget.product != null &&
          widget.product!.seller != null &&
          widget.product!.seller!.shop!.temporaryClose!) {
        temporaryClose = true;
      } else {
        temporaryClose = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CartBottomSheetWidget(
      product: widget.product,
      callback: () {
        showCustomSnackBar(getTranslated('added_to_cart', context), context,
            isError: false);
      },
    );
    // if (vacationIsOn || temporaryClose) {
    //   return showCustomSnackBar(
    //       getTranslated('this_shop_is_close_now', context), context,
    //       isToaster: true);
    // } else {
    //   showModalBottomSheet(
    //       context: context,
    //       isScrollControlled: true,
    //       backgroundColor: Theme.of(context).primaryColor.withOpacity(0),
    //       builder: (con) => CartBottomSheetWidget(
    //             product: widget.product,
    //             callback: () {
    //               showCustomSnackBar(
    //                   getTranslated('added_to_cart', context), context,
    //                   isError: false);
    //             },
    //           ));
    //   return SizedBox();
    // }
  }
}
