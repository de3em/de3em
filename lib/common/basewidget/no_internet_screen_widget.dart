import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/main.dart';
import 'package:da3em/utill/color_resources.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:da3em/common/basewidget/custom_button_widget.dart';
import 'package:da3em/features/dashboard/screens/dashboard_screen.dart';

class NoInternetOrDataScreenWidget extends StatelessWidget {
  final bool isNoInternet;
  final Widget? child;
  final String? message;
  final String? icon;
  final bool icCart;
  const NoInternetOrDataScreenWidget({super.key, required this.isNoInternet, this.child, this.message, this.icon,  this.icCart = false});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.025),
      child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(isNoInternet ? Images.noInternet :icon != null? icon! : Images.noData, width: 75,),
            if(isNoInternet)
            Text(getTranslated('OPPS', context)!, style: titilliumBold.copyWith(fontSize: 30,
              color: Colors.white)),

            const SizedBox(height: Dimensions.paddingSizeDefault),
            Text(isNoInternet ? getTranslated('no_internet_connection', context)! : message != null? getTranslated(message, context)??'' : getTranslated('no_data_found', context)??'',
              textAlign: TextAlign.center, style: textRegular.copyWith()),
            const SizedBox(height: 20),
            isNoInternet ? Container(height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: ColorResources.getYellow(context)),
              child: TextButton(
                onPressed: () async {
                  if(await Connectivity().checkConnectivity() != ConnectivityResult.none) {
                    Navigator.pushReplacement(Get.context!, MaterialPageRoute(builder: (_) => child!));
                  }
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(getTranslated('RETRY', context)!, style: titilliumSemiBold.copyWith(color: Theme.of(context).highlightColor, fontSize: Dimensions.fontSizeLarge)),
                ),
              ),
            ) : const SizedBox.shrink(),

            if(icCart)
              SizedBox(width: 160,
                child: CustomButton(backgroundColor: Colors.transparent,
                    onTap: ()=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> const DashBoardScreen()), (route) => false),
                    isBorder: true, textColor: Theme.of(context).primaryColor,
                    buttonText: '${getTranslated('continue_shopping', context)}'),
              )

          ],
        ),
      ),
    );
  }
}
