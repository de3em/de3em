import 'package:flutter/material.dart';
import 'package:da3em/features/deal/controllers/flash_deal_controller.dart';
import 'package:da3em/features/product/domain/models/product_model.dart';

import 'package:da3em/helper/price_converter.dart';
import 'package:da3em/helper/responsive_helper.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/features/splash/controllers/splash_controller.dart';
import 'package:da3em/theme/controllers/theme_controller.dart';
import 'package:da3em/utill/color_resources.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/common/basewidget/custom_image_widget.dart';
import 'package:da3em/features/product_details/screens/product_details_screen.dart';
import 'package:da3em/features/product_details/widgets/favourite_button_widget.dart';
import 'package:provider/provider.dart';


class FlashDealWidget extends StatelessWidget {
  final Product product;
  final int index;
  const FlashDealWidget({super.key, required this.product,  required this.index});

  @override
  Widget build(BuildContext context) {
    var base = Provider.of<SplashController>(context, listen: false);
    return Consumer<FlashDealController>(
      builder: (context, flashDealProvider,_) {
        return InkWell(onTap: () {
            Navigator.push(context, PageRouteBuilder(transitionDuration: const Duration(milliseconds: 1000),
              pageBuilder: (context, anim1, anim2) => ProductDetails(productId: product.id, slug: product.slug)));
          },
          child: Container(margin: const EdgeInsets.symmetric(vertical : Dimensions.paddingSizeExtraSmall),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                color: Theme.of(context).cardColor,
                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.125))),
            child: Stack(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [

                Padding(padding: const EdgeInsets.all(6.0),
                  child: Container(height: ResponsiveHelper.isTab(context)? MediaQuery.of(context).size.width/3 : 200,
                    decoration: BoxDecoration(border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(.2),width: .25),
                      color: ColorResources.getIconBg(context),
                      borderRadius: const BorderRadius.all( Radius.circular(10))),
                    child: ClipRRect(borderRadius: const BorderRadius.all( Radius.circular(10)),
                      child: CustomImageWidget(image: '${base.baseUrls!.productThumbnailUrl}''/${product.thumbnail}')))),


                if(product.currentStock! < product.minimumOrderQuantity! && product.productType == 'physical')
                  Center(child: Text(getTranslated('out_of_stock', context)??'',
                      style: textRegular.copyWith(color: const Color(0xFFF36A6A)))),

                Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall,
                    Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall,Dimensions.paddingSizeExtraSmall),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center, children: [

                      Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(product.rating!.isNotEmpty ?
                          double.parse(product.rating![0].average!).toStringAsFixed(1) : '0.0',
                              style: textRegular.copyWith(color: Provider.of<ThemeController>(context).darkTheme ?
                            Colors.white : Colors.orange, fontSize: Dimensions.fontSizeSmall)),
                          Icon(Icons.star, color: Provider.of<ThemeController>(context).darkTheme ?
                          Colors.white : Colors.orange, size: 15),
                          Text('(${product.reviewCount.toString()})',
                              style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))])),


                      Text(product.name!, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault), maxLines: 1,
                        overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),


                      Row( mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(product.discount! > 0 ?
                        PriceConverter.convertPrice(context, product.unitPrice) : '',
                          style: robotoBold.copyWith(color: ColorResources.hintTextColor,
                            decoration: TextDecoration.lineThrough, fontSize: Dimensions.fontSizeExtraSmall)),
                        const SizedBox(width: Dimensions.paddingSizeSmall),


                        Text(PriceConverter.convertPrice(context, product.unitPrice,
                            discountType: product.discountType, discount: product.discount),
                          style: robotoBold.copyWith(color: ColorResources.getPrimary(context)))])]))]),


              product.discount! >= 1?
              Positioned(top: 17, left: 9,
                child: Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  height: 25, alignment: Alignment.center,
                  decoration: BoxDecoration(color: ColorResources.getPrimary(context),
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5))),
                  child: Directionality(textDirection: TextDirection.ltr,
                    child: Text(PriceConverter.percentageCalculation(context, product.unitPrice,
                      product.discount, product.discountType,),
                      style: textRegular.copyWith(color: Theme.of(context).highlightColor,
                          fontSize: Dimensions.fontSizeSmall)),
                  ))) : const SizedBox.shrink(),

              Positioned(top: 15, right: 15, child: FavouriteButtonWidget(
                  backgroundColor: ColorResources.getImageBg(context), productId: product.id)),
            ]),
          ),
        );
      }
    );
  }
}
