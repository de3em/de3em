import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/screens/profile_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/not_logged_in_bottom_sheet_widget.dart';
import 'package:provider/provider.dart';

class ProfileInfoSectionWidget extends StatelessWidget {
  const ProfileInfoSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isGuestMode =
        !Provider.of<AuthController>(context, listen: false).isLoggedIn();
    return Consumer<ProfileController>(builder: (context, profile, _) {
      return SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          // decoration: BoxDecoration(
          //   color: Provider.of<ThemeController>(context).darkTheme ?
          //   Theme.of(context).primaryColor.withOpacity(.30) : Theme.of(context).primaryColor),
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(children: [
                InkWell(
                  onTap: () {
                    if (isGuestMode) {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (_) => const NotLoggedInBottomSheetWidget());
                    } else {
                      if (profile.userInfoModel != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ProfileScreen()));
                      }
                    }
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          shape: BoxShape.circle,
                        ),
                        child:
                            Provider.of<AuthController>(context, listen: false)
                                    .isLoggedIn()
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        profile.userInfoModel?.image != null
                                            ? NetworkImage(
                                                profile.userInfoModel!.image!)
                                            : null,
                                    child: profile.userInfoModel?.image == null
                                        ? Text(
                                            profile.userInfoModel?.fName?[0]
                                                    .toUpperCase() ??
                                                'G',
                                            style: robotoBold.copyWith(
                                              color: ColorResources.getPrimary(
                                                  context),
                                              fontSize: 20,
                                            ),
                                          )
                                        : null,
                                  )
                                :
                                // Image.asset(Images.guestProfile)
                                Center(
                                    child: Icon(Icons.person,
                                        color: Theme.of(context).primaryColor,
                                        size: 40)),
                      )),
                ),
                const SizedBox(width: 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        !isGuestMode
                            ? '${profile.userInfoModel?.fName ?? ''} ${profile.userInfoModel?.lName ?? ''}'
                            : 'Guest',
                        style: robotoBold.copyWith(
                            fontSize: Dimensions.fontSizeExtraLarge)),
                    // if (!isGuestMode &&
                    //     profile.userInfoModel?.phone != null &&
                    //     profile.userInfoModel!.phone!.isNotEmpty)
                    //   const SizedBox(height: Dimensions.paddingSizeSmall),
                    // if (!isGuestMode)
                    //   Text(profile.userInfoModel?.phone ?? '',
                    //       style: textRegular.copyWith(
                    //           fontSize: Dimensions.fontSizeLarge)),
                  ],
                ),

                // InkWell(onTap: ()=> Provider.of<ThemeController>(context, listen: false).toggleTheme(),
                //   child: Padding(padding: const EdgeInsets.all(8.0),
                //     child: SizedBox(width: 40, child: Image.asset(Provider.of<ThemeController>(context).darkTheme ?
                //     Images.sunnyDay: Images.theme, color: Provider.of<ThemeController>(context).darkTheme ? Colors.white: null))),
                // )
              ])));
    });
  }
}
