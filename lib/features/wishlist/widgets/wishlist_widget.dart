import 'package:flutter/material.dart';
import 'package:da3em/common/basewidget/custom_image_widget.dart';
import 'package:da3em/features/splash/controllers/splash_controller.dart';
import 'package:da3em/features/wishlist/domain/models/wishlist_model.dart';
import 'package:da3em/helper/price_converter.dart';
import 'package:da3em/theme/controllers/theme_controller.dart';
import 'package:da3em/utill/color_resources.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:da3em/features/wishlist/widgets/remove_from_wishlist_bottom_sheet_widget.dart';
import 'package:da3em/features/product_details/screens/product_details_screen.dart';
import 'package:provider/provider.dart';

class WishListWidget extends StatelessWidget {
  final WishlistModel? wishlistModel;
  final int? index;
  const WishListWidget({super.key, this.wishlistModel, this.index});

  @override
  Widget build(BuildContext context) {

    var splashController = Provider.of<SplashController>(context, listen: false);
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        margin: const EdgeInsets.only(top: Dimensions.marginSizeSmall),
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1)),],
            color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(5)),
        child: Padding(padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall, right: Dimensions.paddingSizeDefault),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(width: Dimensions.paddingSizeSmall), Stack(children: [
              Container(decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                border: Border.all(width: .5, color: Theme.of(context).primaryColor.withOpacity(.25)),),
                child: ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                  child: CustomImageWidget(width: 90, height: 90,
                    image: '${splashController.baseUrls!.productThumbnailUrl}/${wishlistModel?.productFullInfo!.thumbnail}',
                  ))),



                  wishlistModel?.productFullInfo!.unitPrice!= null && wishlistModel!.productFullInfo!.discount! > 0?
                  Positioned(top: Dimensions.paddingSizeSmall,left: 0,
                    child: Container(height: 20, padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(Dimensions.paddingSizeExtraSmall),
                          topRight: Radius.circular(Dimensions.paddingSizeExtraSmall)),
                          color: Theme.of(context).primaryColor),
                      child: Text(wishlistModel?.productFullInfo!.unitPrice!=null &&
                          wishlistModel?.productFullInfo!.discount != null &&
                          wishlistModel?.productFullInfo!.discountType != null?
                      PriceConverter.percentageCalculation(context, wishlistModel?.productFullInfo!.unitPrice,
                          wishlistModel!.productFullInfo!.discount, wishlistModel?.productFullInfo!.discountType) : '',
                        style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Colors.white)))):const SizedBox(),
            ]),
            const SizedBox(width: Dimensions.paddingSizeSmall),


            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text(wishlistModel?.productFullInfo?.name ?? '',maxLines: 1,overflow: TextOverflow.ellipsis,
                    style: titilliumSemiBold.copyWith(color: ColorResources.getReviewRattingColor(context),
                        fontSize: Dimensions.fontSizeDefault))),
                const SizedBox(width: Dimensions.paddingSizeExtraSmall),


                InkWell(onTap: (){showModalBottomSheet(backgroundColor: Colors.transparent,
                    context: context, builder: (_) => RemoveFromWishlistBottomSheet(
                        productId : wishlistModel!.productFullInfo!.id!, index: index!));},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                      child: Image.asset(Images.delete, scale: 3, color: ColorResources.getRed(context).withOpacity(.90)))),
              ]),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              Row(children: [wishlistModel!.productFullInfo!.discount != null && wishlistModel!.productFullInfo!.discount!>0?
              Text(wishlistModel!.productFullInfo!.unitPrice != null?
              PriceConverter.convertPrice(context, wishlistModel!.productFullInfo!.unitPrice):'',
                style: titilliumSemiBold.copyWith(color: ColorResources.getReviewRattingColor(context),
                    decoration: TextDecoration.lineThrough),):const SizedBox(),


                wishlistModel!.productFullInfo!.discount != null && wishlistModel!.productFullInfo!.discount!>0?
                const SizedBox(width: Dimensions.paddingSizeSmall):const SizedBox(),


                Text(PriceConverter.convertPrice(context, wishlistModel!.productFullInfo!.unitPrice,
                    discount: wishlistModel!.productFullInfo!.discount,discountType: wishlistModel!.productFullInfo!.discountType),
                  maxLines: 1,overflow: TextOverflow.ellipsis,
                  style: titilliumRegular.copyWith(color: ColorResources.getPrimary(context),
                      fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w700))]),


              Row(children: [
                const Spacer(),
                InkWell(onTap: (){
                  Navigator.push(context, PageRouteBuilder(transitionDuration: const Duration(milliseconds: 1000),
                    pageBuilder: (context, anim1, anim2) => ProductDetails(productId: wishlistModel!.productFullInfo!.id,
                        slug: wishlistModel!.productFullInfo!.slug, isFromWishList: true)));},
                  child: Container(height: 40, margin: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                    alignment: Alignment.center, decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        border: Border.all(width: .5, color: Theme.of(context).primaryColor.withOpacity(.35)),
                        boxShadow: Provider.of<ThemeController>(context, listen: false).darkTheme? null :
                        [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 75, offset: const Offset(0, 1),),],
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                    child: Icon(Icons.shopping_cart_outlined, color: Theme.of(context).primaryColor, size: 25),
                  ),
                ),
              ],
              ),
            ],
            ),
            ),
          ],),
        ),
      ),
    );
  }
}
