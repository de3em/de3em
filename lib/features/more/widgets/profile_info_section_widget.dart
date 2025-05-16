import 'package:flutter/material.dart';
import 'package:da3em/features/auth/controllers/auth_controller.dart';
import 'package:da3em/features/profile/controllers/profile_contrroller.dart';
import 'package:da3em/features/profile/screens/profile_screen.dart';
import 'package:da3em/theme/controllers/theme_controller.dart';
import 'package:da3em/utill/color_resources.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:da3em/common/basewidget/custom_image_widget.dart';
import 'package:da3em/common/basewidget/not_logged_in_bottom_sheet_widget.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';

class ProfileInfoSectionWidget extends StatelessWidget {
  const ProfileInfoSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthController>(context, listen: false).isLoggedIn();
    return Consumer<ProfileController>(
        builder: (context,profile,_) {
          return Container(decoration: BoxDecoration(
              color: Provider.of<ThemeController>(context).darkTheme ?
              Theme.of(context).primaryColor.withOpacity(.30) : Theme.of(context).primaryColor),
            child: Stack(children: [
              Container(transform: Matrix4.translationValues(-10, 0, 0),
                child: Padding(padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(width: 110, child: Image.asset(Images.shadow, opacity: const AlwaysStoppedAnimation(0.75))))),

              Positioned(right: -110,bottom: -100,
                child: Container(width: 200,height: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Theme.of(context).cardColor.withOpacity(.05), width: 25)))),

              Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 70.0,Dimensions.paddingSizeDefault, 30),
                child: Row(children: [

                  Column(mainAxisAlignment: MainAxisAlignment.start, // Aligns children vertically
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                   ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        width: 250,
                        height: 50,
                        child:  Image.asset(
                          Images.logo_white, // Ensure this image exists in your assets
                          width: 200, // Set width for the image
                          height: 70, // Set height for the image
                          fit: BoxFit.cover, // Ensure BoxFit is set
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    Text((getTranslated('user', context)??'' )+' : ${profile.userInfoModel?.id??''} '  ,
                        style: textMedium.copyWith(color: ColorResources.white, fontSize: Dimensions.fontSizeExtraLarge)),


                  ],),
               //   const SizedBox(width: Dimensions.paddingSizeDefault),

                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment:
                  MainAxisAlignment.center, children: [

                    if(!isGuestMode && profile.userInfoModel?.phone != null && profile.userInfoModel!.phone!.isNotEmpty)
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                //    if(!isGuestMode)
                 //   Text(profile.userInfoModel?.phone??'', style: textRegular.copyWith(color: ColorResources.white,
                   //     fontSize: Dimensions.fontSizeLarge)),
                  ],)),

              Row(
          mainAxisAlignment: MainAxisAlignment.end, // Aligns the InkWell to the right
          children: [
                  InkWell(onTap: ()=> Provider.of<ThemeController>(context, listen: false).toggleTheme(),
                    child: Padding(padding: const EdgeInsets.all(8.0),
                      child: SizedBox(width: 40, child: Image.asset(Provider.of<ThemeController>(context).darkTheme ?
                      Images.sunnyDay: Images.theme, color: Provider.of<ThemeController>(context).darkTheme ?
                      Colors.white: null))),
                  )])

                ])),
            ]));
        });
  }
}
