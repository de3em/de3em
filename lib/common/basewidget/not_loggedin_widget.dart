import 'package:flutter/material.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:da3em/common/basewidget/custom_button_widget.dart';
import 'package:da3em/features/auth/screens/auth_screen.dart';
import 'package:da3em/features/dashboard/screens/dashboard_screen.dart';

class NotLoggedInWidget extends StatelessWidget {
  final String? message;
  const NotLoggedInWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
            child: SizedBox(width: 60,child: Image.asset(Images.loginIcon)),),
          Text(getTranslated('please_login', context)!, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge),),

          Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeLarge),
            child: Text( message ?? '${getTranslated('need_to_login', context)}', textAlign: TextAlign.center),),

          Center(child: SizedBox(width: 120,child: CustomButton(buttonText: '${getTranslated('login', context)}',
              backgroundColor: Theme.of(context).primaryColor,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthScreen()))))),

        InkWell(onTap: ()=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> const DashBoardScreen()), (route) => false),
          child: Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
            child: Text(getTranslated('back_to_home', context)!,
              style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                  color: Theme.of(context).primaryColor, decoration: TextDecoration.underline, decorationColor: Theme.of(context).primaryColor),)),
        ),
        ],
      ),
    );
  }
}
