import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:da3em/features/auth/controllers/auth_controller.dart';
import 'package:da3em/features/splash/controllers/splash_controller.dart';
import 'package:da3em/theme/controllers/theme_controller.dart';
import 'package:da3em/utill/color_resources.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:da3em/common/basewidget/not_loggedin_widget.dart';
import 'package:provider/provider.dart';

class CustomExpandedAppBarWidget extends StatelessWidget {
  final String? title;
  final Widget child;
  final Widget? bottomChild;
  final bool isGuestCheck;
  const CustomExpandedAppBarWidget({super.key, required this.title, required this.child, this.bottomChild, this.isGuestCheck = false});

  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthController>(context, listen: false).isLoggedIn();

    return Scaffold(
      floatingActionButton: isGuestCheck ? isGuestMode ? null : bottomChild : bottomChild,
      body: Stack(children: [

        // Background
        Image.asset(
          Images.morePageHeader, height: 150, fit: BoxFit.fill, width: MediaQuery.of(context).size.width,
          color: Provider.of<ThemeController>(context).darkTheme ? Colors.black : Theme.of(context).primaryColor,
        ),

        Positioned(
          top: 40,
          left: Dimensions.paddingSizeSmall,
          right: Dimensions.paddingSizeSmall,
          child: Row(children: [
            CupertinoNavigationBarBackButton(color: Colors.white, onPressed: () {
              Provider.of<SplashController>(context, listen: false).setFromSetting(false);
              Navigator.pop(context);
            } ),
            Text(title!, style: titilliumRegular.copyWith(fontSize: 20, color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
          ]),
        ),

        Container(
          margin: const EdgeInsets.only(top: 120),
          decoration: BoxDecoration(
            color: ColorResources.getHomeBg(context),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: isGuestCheck ? isGuestMode ? const NotLoggedInWidget() : child : child,
        ),
      ]),
    );
  }
}
