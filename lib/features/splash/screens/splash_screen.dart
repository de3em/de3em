import 'dart:async';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:da3em/common/basewidget/bouncy_widget.dart';
import 'package:da3em/features/auth/domain/models/register_model.dart';
import 'package:da3em/features/order_details/screens/order_details_screen.dart';
import 'package:da3em/features/splash/controllers/splash_controller.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/main.dart';
import 'package:da3em/push_notification/models/notification_body.dart';
import 'package:da3em/features/auth/controllers/auth_controller.dart';
import 'package:da3em/utill/app_constants.dart';
import 'package:da3em/utill/color_resources.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:da3em/common/basewidget/no_internet_screen_widget.dart';
import 'package:da3em/features/chat/screens/inbox_screen.dart';
import 'package:da3em/features/dashboard/screens/dashboard_screen.dart';
import 'package:da3em/features/maintenance/maintenance_screen.dart';
import 'package:da3em/features/notification/screens/notification_screen.dart';
import 'package:da3em/features/onboarding/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';

import '../../profile/controllers/profile_contrroller.dart';

class SplashScreen extends StatefulWidget {
  final NotificationBody? body;
  const SplashScreen({super.key, this.body});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (!firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? const SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: isNotConnected ? Colors.red : Colors.green, duration: Duration(seconds: isNotConnected ? 6000 : 3), content: Text(isNotConnected ? getTranslated('no_connection', context)! : getTranslated('connected', context)!, textAlign: TextAlign.center)));
        if (!isNotConnected) {
          _route();
        }
      }
      firstTime = false;
    });

    _route();
  }

  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged.cancel();
  }

  route(bool isRoute, String? token, String? tempToken, String? errorMessage) async {
    var splashController = Provider.of<SplashController>(context, listen: false);
    var authController = Provider.of<AuthController>(context, listen: false);
    var profileController = Provider.of<ProfileController>(context, listen: false);
    if (isRoute) {
      await profileController.getUserInfo(context);
      Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);
    }

  }

  String randomNumber([int from = 10000, int to = 99999]) {
    var random = Random();
    return (from + random.nextInt(to - from)).toString();
  }

  Future<void> _route() async {
    // is logged in
    var isLogged = Provider.of<AuthController>(context, listen: false).isLoggedIn();

    if (!isLogged) {
      var authProvider = Provider.of<AuthController>(context, listen: false);

      var randomNumberGenerated = randomNumber(0500000000, 0799999999);

      var registerModel = RegisterModel();
      registerModel.email = randomNumberGenerated + '@gmail.com';
      registerModel.phone = randomNumberGenerated;
      registerModel.fName = randomNumberGenerated;
      registerModel.lName = randomNumberGenerated;
      registerModel.password = randomNumberGenerated;
      await authProvider.registration(registerModel, route);
      print('registration done');
    }

    Provider.of<SplashController>(context, listen: false).initConfig(context).then((bool isSuccess) {
      if (isSuccess) {
        Provider.of<SplashController>(Get.context!, listen: false).initSharedPrefData();
        Timer(const Duration(seconds: 1), () {
          if (Provider.of<SplashController>(Get.context!, listen: false).configModel!.maintenanceMode!) {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (_) => const MaintenanceScreen()));
          } else if (Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn()) {
            Provider.of<AuthController>(Get.context!, listen: false).updateToken(Get.context!);
            if (widget.body != null) {
              if (widget.body!.type == 'order') {
                Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => OrderDetailsScreen(orderId: widget.body!.orderId)));
              } else if (widget.body!.type == 'notification') {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const NotificationScreen()));
              } else {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const InboxScreen(
                      isBackButtonExist: true,
                    )));
              }
            } else {
              Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));
            }
          } else if (Provider.of<SplashController>(Get.context!, listen: false).showIntro()!) {
            Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => OnBoardingScreen(indicatorColor: ColorResources.grey, selectedIndicatorColor: Theme.of(context).primaryColor)));
          } else {
            if (Provider.of<AuthController>(context, listen: false).getGuestToken() != null && Provider.of<AuthController>(context, listen: false).getGuestToken() != '1') {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));
            } else {
              Provider.of<AuthController>(context, listen: false).getGuestIdUrl();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Provider.of<SplashController>(context).hasConnection
          ? SizedBox(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, children: [
          Spacer(),
          SizedBox(width: 150, child: Image.asset(Images.icon, width: 150.0)),
          Spacer(),
          // Text(AppConstants.appName, style: textRegular.copyWith(fontSize: Dimensions.fontSizeOverLarge)),
          Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
              child: Text(AppConstants.slogan,
                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
          SizedBox(height: 100)
        ]),
      )
          : const NoInternetOrDataScreenWidget(isNoInternet: true, child: SplashScreen()),
    );
  }

}
