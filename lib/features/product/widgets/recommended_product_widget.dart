import 'package:flutter/material.dart';
import 'package:da3em/features/product/controllers/product_controller.dart';
import 'package:da3em/features/splash/controllers/splash_controller.dart';
import 'package:da3em/helper/price_converter.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/theme/controllers/theme_controller.dart';
import 'package:da3em/utill/color_resources.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:da3em/common/basewidget/custom_image_widget.dart';
import 'package:da3em/features/home/shimmers/recommended_product_shimmer.dart';
import 'package:da3em/features/product_details/screens/product_details_screen.dart';
import 'package:da3em/features/product_details/widgets/favourite_button_widget.dart';
import 'package:provider/provider.dart';

class RecommendedProductWidget extends StatelessWidget {
  final bool fromAsterTheme;
  const RecommendedProductWidget({super.key, this.fromAsterTheme = false});

  @override
  Widget build(BuildContext context) {
    var splashController =
        Provider.of<SplashController>(context, listen: false);
    return Container(
      padding: const EdgeInsets.only(
          top: Dimensions.paddingSizeSmall,
          bottom: Dimensions.paddingSizeDefault),
      color: Theme.of(context).primaryColor.withOpacity(.05),
      child: Column(
        children: [
          Consumer<ProductController>(
            builder: (context, recommended, child) {
              String? ratting = recommended.recommendedProduct != null &&
                      recommended.recommendedProduct!.rating != null &&
                      recommended.recommendedProduct!.rating!.isNotEmpty
                  ? recommended.recommendedProduct!.rating![0].average
                  : "0";

              return recommended.recommendedProduct != null
                  ? InkWell(
                      onTap: () {
                        // Navigator.push(context, PageRouteBuilder(
                        //   transitionDuration: const Duration(milliseconds: 1000),
                        //   pageBuilder: (context, anim1, anim2) => ProductDetails(productId: recommended.recommendedProduct!.id,
                        //     slug: recommended.recommendedProduct!.slug)));
                        showModalBottomSheet(
                            // constraints: BoxConstraints(
                            //   maxHeight: MediaQuery.of(context).size.height * 0.8,
                            // ),
                            // anchorPoint: Offset(0.5, 0.5),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            backgroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return SingleChildScrollView(
                                child: ProductDetails(
                                  productId: recommended.recommendedProduct!.id,
                                  slug: recommended.recommendedProduct!.slug,
                                ),
                              );
                            });
                      },
                      child: Stack(
                        children: [
                          Positioned(
                              top: -10,
                              left: MediaQuery.of(context).size.width * 0.35,
                              child: Image.asset(
                                Images.dealOfTheDay,
                                width: 150,
                                height: 150,
                                opacity: const AlwaysStoppedAnimation(0.25),
                              )),
                          Column(
                            children: [
                              fromAsterTheme
                                  ? Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical:
                                                Dimensions.paddingSizeSmall),
                                        child: Text(
                                          getTranslated('dont_miss_the_chance',
                                                  context) ??
                                              '',
                                          style: textBold.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeSmall,
                                              color:
                                                  Provider.of<ThemeController>(
                                                              context,
                                                              listen: false)
                                                          .darkTheme
                                                      ? Theme.of(context)
                                                          .hintColor
                                                      : Theme.of(context)
                                                          .primaryColor),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              bottom:
                                                  Dimensions.paddingSizeSmall),
                                          child: Text(
                                              getTranslated(
                                                      'lets_shopping_today',
                                                      context) ??
                                                  '',
                                              style: textBold.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeExtraLarge,
                                                  color: Provider.of<ThemeController>(
                                                              context,
                                                              listen: false)
                                                          .darkTheme
                                                      ? Theme.of(context)
                                                          .hintColor
                                                      : Theme.of(context)
                                                          .primaryColor)))
                                    ])
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: Dimensions.paddingSizeDefault,
                                          top:
                                              Dimensions.paddingSizeExtraSmall),
                                      child: Text(
                                        getTranslated(
                                                'deal_of_the_day', context) ??
                                            '',
                                        style: textBold.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeExtraLarge,
                                            color: Provider.of<ThemeController>(
                                                        context,
                                                        listen: false)
                                                    .darkTheme
                                                ? Theme.of(context).hintColor
                                                : Theme.of(context)
                                                    .primaryColor),
                                      ),
                                    ),
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.homePagePadding),
                                    child: Container(
                                      padding: const EdgeInsets.all(
                                          Dimensions.paddingSizeDefault),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(
                                                  Dimensions.paddingSizeSmall)),
                                          color: Provider.of<ThemeController>(
                                                      context,
                                                      listen: false)
                                                  .darkTheme
                                              ? Theme.of(context).highlightColor
                                              : Theme.of(context)
                                                  .highlightColor,
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(.20),
                                              width: 1)),
                                      child: Row(
                                        children: [
                                          recommended.recommendedProduct != null && recommended.recommendedProduct!.thumbnail != null
                                              ? Container(
                                                  width: 160,
                                                  height: (recommended
                                                                  .recommendedProduct!
                                                                  .currentStock! <
                                                              recommended
                                                                  .recommendedProduct!
                                                                  .minimumOrderQuantity! &&
                                                          recommended.recommendedProduct!.productType ==
                                                              'physical')
                                                      ? 170
                                                      : 150,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .highlightColor,
                                                      border: Border.all(
                                                          color: Theme.of(context)
                                                              .primaryColor
                                                              .withOpacity(.20),
                                                          width: .5),
                                                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                                                  child: ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(5)), child: CustomImageWidget(image: '${splashController.baseUrls!.productThumbnailUrl}/${recommended.recommendedProduct!.thumbnail}')))
                                              : const SizedBox(),
                                          const SizedBox(
                                              width: Dimensions
                                                  .paddingSizeDefault),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.5,
                                                    child: Text(
                                                        recommended
                                                                .recommendedProduct!
                                                                .name ??
                                                            '',
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: textRegular
                                                            .copyWith())),

                                                if (recommended
                                                            .recommendedProduct!
                                                            .currentStock! ==
                                                        0 &&
                                                    recommended
                                                            .recommendedProduct!
                                                            .productType ==
                                                        'physical')
                                                  Padding(
                                                      padding: const EdgeInsets.only(
                                                          bottom: Dimensions
                                                              .paddingSizeExtraSmall),
                                                      child: Text(
                                                          getTranslated(
                                                                  'out_of_stock', context) ??
                                                              '',
                                                          style: textRegular.copyWith(
                                                              color: const Color(0xFFF36A6A)))),

                                                //  ox(height: Dimensions.paddingSizeSmall,),

                                                Row(children: [
                                                  const SizedBox(
                                                      height: Dimensions
                                                          .paddingSizeExtraExtraSmall),
                                                  recommended
                                                                  .recommendedProduct !=
                                                              null &&
                                                          recommended
                                                                  .recommendedProduct!
                                                                  .discount !=
                                                              null &&
                                                          recommended
                                                                  .recommendedProduct!
                                                                  .discount! >
                                                              0
                                                      ? Text(
                                                          PriceConverter.convertPrice(
                                                              context,
                                                              recommended
                                                                  .recommendedProduct!
                                                                  .unitPrice),
                                                          style: textRegular
                                                              .copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            fontSize: Dimensions
                                                                .fontSizeSmall,
                                                          ),
                                                        )
                                                      : const SizedBox.shrink(),
                                                  // const SizedBox(height: Dimensions.paddingSizeExtraExtraSmall,
                                                  //     width: Dimensions.paddingSizeExtraSmall),

                                                  recommended.recommendedProduct !=
                                                              null &&
                                                          recommended
                                                                  .recommendedProduct!
                                                                  .unitPrice !=
                                                              null
                                                      ? Text(
                                                          PriceConverter.convertPrice(
                                                              context,
                                                              recommended
                                                                  .recommendedProduct!.unitPrice,
                                                              discountType: recommended
                                                                  .recommendedProduct!
                                                                  .discountType,
                                                              discount: recommended
                                                                  .recommendedProduct!
                                                                  .discount),
                                                          style:
                                                              textBold.copyWith(
                                                            color: ColorResources
                                                                .getPrimary(
                                                                    context),
                                                          ))
                                                      : const SizedBox(),
                                                ]),
                                                // const SizedBox(height: Dimensions.paddingSizeSmall,),
                                                SizedBox(
                                                  height: 55,
                                                ),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                            width: 110,
                                                            height: 35,
                                                            decoration: BoxDecoration(
                                                                borderRadius: const BorderRadius.all(
                                                                    Radius.circular(Dimensions
                                                                        .paddingSizeOverLarge)),
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor),
                                                            child: Center(
                                                                child: Text(
                                                                    getTranslated(
                                                                        'buy_now',
                                                                        context)!,
                                                                    style: const TextStyle(
                                                                        color: Colors.white)))),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(Icons.star,
                                                                  color: Provider.of<ThemeController>(
                                                                              context)
                                                                          .darkTheme
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .orange,
                                                                  size: 15),
                                                              Text(
                                                                  double.parse(
                                                                          ratting!)
                                                                      .toStringAsFixed(
                                                                          1),
                                                                  style: titilliumBold
                                                                      .copyWith(
                                                                          fontSize:
                                                                              Dimensions.fontSizeDefault)),
                                                              Text(
                                                                  '(${recommended.recommendedProduct?.reviewCount ?? '0'})',
                                                                  style: textRegular.copyWith(
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontSizeDefault,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .hintColor)),
                                                            ]),
                                                      ],
                                                    )),

                                                // const SizedB
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 10,
                                      right: 25,
                                      child: FavouriteButtonWidget(
                                          backgroundColor:
                                              ColorResources.getImageBg(
                                                  context),
                                          productId: recommended
                                              .recommendedProduct?.id)),
                                  recommended.recommendedProduct != null &&
                                          recommended.recommendedProduct!
                                                  .discount !=
                                              null &&
                                          recommended.recommendedProduct!
                                                  .discount! >
                                              0
                                      ? Positioned(
                                          top: 25,
                                          left: 32,
                                          child: Container(
                                              height: 20,
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: Dimensions
                                                      .paddingSizeExtraSmall),
                                              decoration: BoxDecoration(
                                                color:
                                                    ColorResources.getPrimary(
                                                        context),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        bottomRight:
                                                            Radius.circular(5),
                                                        topRight:
                                                            Radius.circular(5)),
                                              ),
                                              child: Center(
                                                  child: Directionality(
                                                textDirection:
                                                    TextDirection.ltr,
                                                child: Text(
                                                  PriceConverter
                                                      .percentageCalculation(
                                                          context,
                                                          recommended
                                                              .recommendedProduct!
                                                              .unitPrice,
                                                          recommended
                                                              .recommendedProduct!
                                                              .discount,
                                                          recommended
                                                              .recommendedProduct!
                                                              .discountType),
                                                  style: textRegular.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary,
                                                      fontSize: Dimensions
                                                          .fontSizeSmall),
                                                ),
                                              ))))
                                      : const SizedBox.shrink(),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : const RecommendedProductShimmer();
            },
          ),
        ],
      ),
    );
  }
}
