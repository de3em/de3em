import 'package:flutter/material.dart';
import 'package:da3em/features/address/screens/address_list_screen.dart';
import 'package:da3em/features/category/screens/category_screen.dart';
import 'package:da3em/features/more/widgets/title_button_widget.dart';
import 'package:da3em/features/profile/screens/profile_screen.dart';
import 'package:da3em/features/refer_and_earn/screens/refer_and_earn_screen.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../auth/controllers/auth_controller.dart';

class ProfileScreenInfo extends StatelessWidget {
  const ProfileScreenInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const ListTile(
            enabled: false,
            leading: Icon(Iconsax.medal_star),
            title: Text('Profile Informations'),
          ),
          if (Provider.of<AuthController>(context, listen: false).isLoggedIn())
            MenuButtonWidget(
                icon: Iconsax.user,
                title: getTranslated('profile', context),
                navigateTo: const ProfileScreen()),
          MenuButtonWidget(
              icon: Iconsax.location,
              title: getTranslated('addresses', context),
              navigateTo: const AddressListScreen()),
          // MenuButtonWidget(
          //     icon: Iconsax.ticket_discount,
          //     title: getTranslated('coupons', context),
          // navigateTo: const CouponList()),
          if (Provider.of<AuthController>(context, listen: false).isLoggedIn())
            MenuButtonWidget(
                icon: Iconsax.refresh,
                title: getTranslated('refer_and_earn', context),
                isProfile: true,
                navigateTo: const ReferAndEarnScreen()),
          // MenuButtonWidget(
          //     icon: Iconsax.category,
          //     title: getTranslated('CATEGORY', context),
          //     navigateTo: const CategoryScreen()),
        ],
      ),
    );
  }
}
