import 'package:flutter/material.dart';
import 'package:da3em/common/basewidget/not_logged_in_bottom_sheet_widget.dart';
import 'package:da3em/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:da3em/features/chat/controllers/chat_controller.dart';
import 'package:da3em/features/splash/controllers/splash_controller.dart';
import 'package:da3em/helper/price_converter.dart';
import 'package:da3em/helper/responsive_helper.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/features/auth/controllers/auth_controller.dart';
import 'package:da3em/features/shop/controllers/shop_controller.dart';
import 'package:da3em/theme/controllers/theme_controller.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:da3em/common/basewidget/custom_image_widget.dart';
import 'package:da3em/features/chat/screens/chat_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopInfoWidget extends StatelessWidget {
  final bool vacationIsOn;
  final bool temporaryClose;
  final String sellerName;
  final int sellerId;
  final String banner;
  final String shopImage;
  final String phone;
  final String follow;
  const ShopInfoWidget({super.key, required this.vacationIsOn, required this.sellerName,
    required this.sellerId, required this.banner, required this.shopImage, required this.temporaryClose, required this.phone, required this.follow});

  @override
  Widget build(BuildContext context) {
    var splashController = Provider.of<SplashController>(context, listen: false);

    return Column(children: [
   /*   CustomImageWidget(
        image:
      sellerId == 0 ?
      splashController.configModel!.companyLogo?.path ?? '' : banner,
      placeholder: Images.placeholder_3x1,width: MediaQuery.of(context).size.width,
        height: ResponsiveHelper.isTab(context)? 250 : 120,),
*/
        Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Container(transform: Matrix4.translationValues(0, -20, 0),
            padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeSmall,
                vertical: Dimensions.paddingSizeDefault ),

            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor,
                boxShadow: Provider.of<ThemeController>(context,listen: false).darkTheme? null:
                [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 5)]),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(children: [

                Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).highlightColor,
                    boxShadow: Provider.of<ThemeController>(context,listen: false).darkTheme? null:
                    [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 5)]),
                  child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    child: CustomImageWidget(height: 80, width: 80, fit: BoxFit.cover,
                      image: sellerId == 0 ?
                      splashController.configModel!.companyFavIcon?.path ?? '' :
                      shopImage))),
                if(temporaryClose || vacationIsOn)
                  Container(width: 80,height: 80,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.5),
                        borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraSmall)),)),

                temporaryClose?
                Positioned(top: 0,bottom: 0,left: 0,right: 0,
                  child: Align(alignment: Alignment.center,
                      child: Center(child:
                      Text(getTranslated('temporary_closed', context)!.replaceAll(' ', '\n'),
                          textAlign: TextAlign.center,
                          style: textRegular.copyWith(color: Colors.white,
                              fontSize: Dimensions.fontSizeExtraSmall))))):

                vacationIsOn?
                Positioned(top: 0,bottom: 0,left: 0,right: 0,
                  child: Align(alignment: Alignment.center,
                      child: Center(child:
                      Text(getTranslated('close_for_now', context)!,
                          textAlign: TextAlign.center,
                          style: textRegular.copyWith(color: Colors.white,
                              fontSize: Dimensions.fontSizeExtraSmall))))):
                const SizedBox()]),

              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(child:
              Consumer<ShopController>(
                  builder: (context, sellerProvider,_) {
                    String ratting = sellerProvider.sellerInfoModel != null && sellerProvider.sellerInfoModel!.avgRating != null?
                    sellerProvider.sellerInfoModel!.avgRating.toString() : "0";
             //--------------------------------------- nom of store and icon
                      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes space between items
                          children: [
                            Expanded(
                              child: Text(
                                sellerName,
                                style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                              child: InkWell(
                                onTap: () {
                                  if (vacationIsOn || temporaryClose) {
                                    showCustomSnackBar(
                                      "${getTranslated("this_shop_is_close_now", context)}",
                                      context,
                                    );
                                  } else {
                                    if (!Provider.of<AuthController>(context, listen: false).isLoggedIn()) {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (_) => const NotLoggedInBottomSheetWidget(),
                                      );
                                    } else {
                                      Provider.of<ChatController>(context, listen: false).setUserTypeIndex(context, 1);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ChatScreen(id: sellerId, name: sellerName, userType: 1),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Image.asset(
                                  Images.chatImage,
                                  height: ResponsiveHelper.isTab(context) ? Dimensions.iconSizeLarge : Dimensions.iconSizeDefault,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall), // Add padding for the call icon
                              child: InkWell(
                                onTap: () async {
                                  if (!Provider.of<AuthController>(context, listen: false).isLoggedIn()) {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (_) => const NotLoggedInBottomSheetWidget(),
                                    );
                                  } else if (sellerProvider.sellerInfoModel != null &&
                                      ((sellerProvider.sellerInfoModel?.seller?.shop?.temporaryClose ?? false) ||
                                          (sellerProvider.sellerInfoModel?.seller?.shop?.vacationStatus ?? false))) {
                                    showCustomSnackBar(
                                      "${getTranslated("this_shop_is_close_now", context)}",
                                      context,
                                    );
                                  } else if (sellerProvider.sellerInfoModel != null) {
                                    String? phoneNumber = sellerProvider.sellerInfoModel?.seller?.phone;
                                    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
                                    if (await canLaunchUrl(callUri)) {
                                      await launchUrl(callUri);
                                    } else {
                                      showCustomSnackBar(
                                        "${getTranslated("could_not_launch_phone", context)}",
                                        context,
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).brightness == Brightness.light
                                        ? Colors.white
                                        : Colors.grey[900], // White for light theme, dark grey for dark theme
                                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 0.0,
                                    ), // Blue border
                                  ),
                                  child: Image.asset(
                                    Images.callIcon,
                                    height: Dimensions.iconSizeDefault,
                                    color: Colors.blue, // Blue icon color
                                  ),
                                ),
                                splashColor: Colors.blue.withOpacity(0.2), // Blue splash color
                                highlightColor: Colors.blue.withOpacity(0.2), // Blue highlight color
                              ),
                            ),
                          ],
                        ),





                        sellerProvider.sellerInfoModel != null?
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(children: [
                            const Icon(Icons.star_rate_rounded, color: Colors.orange),

                            Text(double.parse(ratting).toStringAsFixed(1), style: textRegular),

                            if(sellerProvider.sellerInfoModel!.minimumOrderAmount != null && sellerProvider.sellerInfoModel!.minimumOrderAmount! > 0)
                            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                              child: Text('|', style: textRegular.copyWith(color: Theme.of(context).primaryColor),),),

                            if(sellerProvider.sellerInfoModel!.minimumOrderAmount != null
                                && sellerProvider.sellerInfoModel!.minimumOrderAmount! > 0)
                            Text('${sellerProvider.sellerInfoModel!.totalReview} ${getTranslated('reviews', context)}',
                              style: titleRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).primaryColor),
                              maxLines: 1, overflow: TextOverflow.ellipsis)]),


                          const SizedBox(height: Dimensions.paddingSizeSmall),


                          Row(children: [

                            (sellerProvider.sellerInfoModel!.minimumOrderAmount != null && sellerProvider.sellerInfoModel!.minimumOrderAmount! > 0)?
                            Text('${PriceConverter.convertPrice(context, sellerProvider.sellerInfoModel!.minimumOrderAmount)} '
                                '${getTranslated('minimum_order', context)}',
                              style: titleRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                              maxLines: 1, overflow: TextOverflow.ellipsis,):


                            Text('${sellerProvider.sellerInfoModel!.totalReview} ${getTranslated('reviews', context)}',
                              style: titleRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).primaryColor), maxLines: 1, overflow: TextOverflow.ellipsis,),


                            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                              child: Text('|', style: textRegular.copyWith(color: Theme.of(context).primaryColor),),),

                            Text('${sellerProvider.sellerInfoModel!.totalProduct} ${getTranslated('products', context)}',
                              style: titleRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).primaryColor), maxLines: 1, overflow: TextOverflow.ellipsis),
                         ///// moh produit detail
                            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                              child: Text('|', style: textRegular.copyWith(color: Theme.of(context).primaryColor),),),

                            Text('${sellerProvider.view_shop} ${getTranslated('views', context)}',
                                style: titleRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                    color: Theme.of(context).primaryColor), maxLines: 1, overflow: TextOverflow.ellipsis),
                          //**********
                         /* Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                            child: Text('|', style: textRegular.copyWith(color: Theme.of(context).primaryColor),),),

                          Text('0 ${getTranslated('follow', context)}',
                              style: titleRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).primaryColor), maxLines: 1, overflow: TextOverflow.ellipsis)
                                  */
                                  ]),

                      ]):const SizedBox(),
                      ],
                      );
                    }
                ),
              ),

            ]),
          ),
        ),
      ],
    );
  }
}
