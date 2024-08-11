import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/controllers/cart_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SquareButtonWidget extends StatelessWidget {
  final IconData icon;
  final String? title;
  final Widget navigateTo;
  final int count;
  final bool hasCount;
  final bool isWallet;
  final bool isLoyalty;

  const SquareButtonWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.navigateTo,
      required this.count,
      required this.hasCount,
      this.isWallet = false,
      this.isLoyalty = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => navigateTo)),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: 50,
              height: 39,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                // color: Provider.of<ThemeController>(context).darkTheme ?
                // Theme.of(context).primaryColor.withOpacity(.30) : Theme.of(context).primaryColor
                borderRadius: BorderRadius.circular(14),
              ),
              child: Stack(children: [
                // Positioned(
                //     top: -80,
                //     left: -10,
                //     right: -10,
                //     child: Container(
                //         height: 120,
                //         decoration: BoxDecoration(
                //             border: Border.all(
                //                 color: Colors.black.withOpacity(.07),
                //                 width: 15),
                //
                //
                //C           borderRadius: BorderRadius.circular(100)))),
                Center(
                  child: Icon(icon,
                      size: 30, color: ColorResources.getPrimary(context)),
                ),

                // if (isWallet)
                //   Positioned(
                //       right: 10,
                //       bottom: 10,
                //       child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.end,
                //           children: [])),
                hasCount
                    ? Positioned(
                        top: 5,
                        right: 5,
                        child: Consumer<CartController>(
                            builder: (context, cart, child) {
                          return CircleAvatar(
                              radius: 10,
                              backgroundColor: ColorResources.red,
                              child: Text(count.toString(),
                                  style: titilliumSemiBold.copyWith(
                                      fontSize:
                                          Dimensions.fontSizeExtraSmall)));
                        }))
                    : const SizedBox(),
              ])),
        ),
        Text(title ?? '',
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: titilliumRegular.copyWith(
                fontSize: Dimensions.fontSizeDefault,
                color: Theme.of(context).textTheme.bodyLarge?.color)),
      ]),
    );
  }
}
