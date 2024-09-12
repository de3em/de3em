import 'package:flutter/material.dart';
import 'package:da3em/features/coupon/screens/coupon_screen.dart';
import 'package:da3em/features/more/widgets/square_item_widget.dart';
import 'package:da3em/features/order_details/screens/guest_track_order_screen.dart';
import 'package:da3em/features/wallet/screens/wallet_screen.dart';
import 'package:da3em/features/wishlist/controllers/wishlist_controller.dart';
import 'package:da3em/features/wishlist/screens/wishlist_screen.dart';
import 'package:da3em/helper/responsive_helper.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/features/cart/controllers/cart_controller.dart';
import 'package:da3em/features/auth/controllers/auth_controller.dart';
import 'package:da3em/features/profile/controllers/profile_contrroller.dart';
import 'package:da3em/features/splash/controllers/splash_controller.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:da3em/features/cart/screens/cart_screen.dart';
import 'package:da3em/features/loyaltyPoint/screens/loyalty_point_screen.dart';
import 'package:da3em/features/banner/screens/offers_banner_screen.dart';
import 'package:da3em/features/order/screens/order_screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class MoreHorizontalSection extends StatelessWidget {
  const MoreHorizontalSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isGuestMode =
        !Provider.of<AuthController>(context, listen: false).isLoggedIn();
    return Consumer<ProfileController>(builder: (context, profileProvider, _) {
      return SizedBox(
        height: ResponsiveHelper.isTab(context) ? 135 : 90,
        child: Center(
          child: Row(
              children: [
                if (Provider.of<SplashController>(context, listen: false)
                        .configModel!
                        .activeTheme !=
                    "theme_fashion")
                  Expanded(
                    child: SquareButtonWidget(
                      icon: Iconsax.cake,
                      title: getTranslated('offers', context),
                      navigateTo: const OffersBannerScreen(),
                      count: 0,
                      hasCount: false,
                    ),
                  ),

                if (!isGuestMode &&
                    Provider.of<SplashController>(context, listen: false)
                            .configModel!
                            .walletStatus ==
                        1)
                  Expanded(
                    child: SquareButtonWidget(
                      icon: Iconsax.wallet,
                      title: getTranslated('wallet', context),
                      navigateTo: const WalletScreen(),
                      count: 1,
                      hasCount: false,
                      isWallet: true,
                    ),
                  ),

                if (!isGuestMode &&
                    Provider.of<SplashController>(context, listen: false)
                            .configModel!
                            .loyaltyPointStatus ==
                        1)
                  Expanded(
                    child: SquareButtonWidget(
                        icon: Iconsax.gift,
                        title: getTranslated('loyalty_point', context),
                        navigateTo: const LoyaltyPointScreen(),
                        count: 1,
                        hasCount: false,
                        isWallet: true,
                        isLoyalty: true),
                  ),

                if (!isGuestMode)
                  Expanded(
                    child: SquareButtonWidget(
                        icon: Iconsax.shopping_cart,
                        title: getTranslated('orders', context),
                        navigateTo: const OrderScreen(),
                        count: 1,
                        hasCount: false,
                        isWallet: true,
                        isLoyalty: true),
                  ),

                // SquareButtonWidget(image: Images.cartImage, title: getTranslated('cart', context),
                //   navigateTo: const CartScreen(),
                //   count: Provider.of<CartController>(context,listen: false).cartList.length, hasCount: true,),

                Expanded(
                  child: SquareButtonWidget(
                    icon: Iconsax.heart,
                    title: getTranslated('wishlist', context),
                    navigateTo: const WishListScreen(),
                    count: Provider.of<AuthController>(context, listen: false)
                                .isLoggedIn() &&
                            Provider.of<WishListController>(context,
                                        listen: false)
                                    .wishList !=
                                null &&
                            Provider.of<WishListController>(context,
                                    listen: false)
                                .wishList!
                                .isNotEmpty
                        ? Provider.of<WishListController>(context,
                                listen: false)
                            .wishList!
                            .length
                        : 0,
                    hasCount: false,
                  ),
                ),
                Expanded(
                  child: SquareButtonWidget(
                    icon: Iconsax.sms_tracking,
                    title: getTranslated('TRACK_ORDER', context),
                    navigateTo: const GuestTrackOrderScreen(),
                    count: 0,
                    hasCount: false,
                  ),
                ),
                Expanded(
                  child: SquareButtonWidget(
                    icon: Iconsax.ticket_discount,
                    title: getTranslated('coupons', context),
                    navigateTo: const CouponList(),
                    count: 0,
                    hasCount: false,
                  ),
                ),
              ]),
        ),
      );
    });
  }
}
