import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/screens/product_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/favourite_button_widget.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  final Product productModel;
  const ProductWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    String ratting = productModel.rating != null && productModel.rating!.isNotEmpty ? productModel.rating![0].average! : "0";

    return InkWell(
      onTap: () {
        Navigator.push(context, PageRouteBuilder(transitionDuration: const Duration(milliseconds: 1000), pageBuilder: (context, anim1, anim2) => ProductDetails(productId: productModel.id, slug: productModel.slug)));
      },
      child: Container(
        margin: const EdgeInsetsDirectional.only(start: 12),
        // padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).highlightColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Provider.of<ThemeController>(context, listen: false).darkTheme ? Theme.of(context).primaryColor.withOpacity(.05) : ColorResources.getIconBg(context),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                    child: CustomImageWidget(
                      image: '${Provider.of<SplashController>(context, listen: false).baseUrls!.productThumbnailUrl}/${productModel.thumbnail}',
                      height: MediaQuery.of(context).size.width / 2.45,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Card(
                    child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Icon(Icons.star_rate_rounded, color: Colors.orange, size: 20),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 2.0, end: 4),
                        child: Text(double.parse(ratting).toStringAsFixed(1), style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
                      ),
                      // Text('(${productModel.reviewCount.toString()})', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor))
                    ]),
                  ),
                ),

                // Off

                productModel.discount! > 0
                    ? Positioned(
                        top: 10,
                        left: 0,
                        child: Container(
                          height: 20,
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                          decoration: BoxDecoration(
                            color: ColorResources.getPrimary(context),
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.paddingSizeExtraSmall), bottomRight: Radius.circular(Dimensions.paddingSizeExtraSmall)),
                          ),
                          child: Center(
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(PriceConverter.percentageCalculation(context, productModel.unitPrice, productModel.discount, productModel.discountType), style: textRegular.copyWith(color: Theme.of(context).highlightColor, fontSize: Dimensions.fontSizeSmall)),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),

                Positioned(
                  top: 5,
                  right: 5,
                  child: FavouriteButtonWidget(
                    backgroundColor: ColorResources.getImageBg(context),
                    productId: productModel.id,
                  ),
                ),
              ],
            ),

            // Product Details
            Padding(
              padding: const EdgeInsets.only(
                top: Dimensions.paddingSizeSmall,
                left: Dimensions.paddingSizeSmall,
                right: Dimensions.paddingSizeSmall,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(PriceConverter.convertPrice(context, productModel.unitPrice, discountType: productModel.discountType, discount: productModel.discount), style: titilliumSemiBold.copyWith(color: ColorResources.getPrimary(context))),
                  if (productModel.currentStock! == 0 && productModel.productType == 'physical') Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall), child: Text(getTranslated('out_of_stock', context) ?? '', style: textRegular.copyWith(color: const Color(0xFFF36A6A)))),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      productModel.name ?? '',
                      style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault - 2),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  productModel.discount != null && productModel.discount! > 0
                      ? Text(
                          PriceConverter.convertPrice(context, productModel.unitPrice),
                          style: titleRegular.copyWith(
                            color: Theme.of(context).hintColor,
                            decoration: TextDecoration.lineThrough,
                            fontSize: Dimensions.fontSizeSmall,
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
