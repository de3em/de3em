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

class ProductWidget extends StatefulWidget {
  final Product productModel;
  const ProductWidget({super.key, required this.productModel});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String ratting = widget.productModel.rating != null &&
            widget.productModel.rating!.isNotEmpty
        ? widget.productModel.rating![0].average!
        : "0";

    return InkWell(
      onTap: () {
        showModalBottomSheet(
            // constraints: BoxConstraints(
            //   maxHeight: MediaQuery.of(context).size.height * 0.8,
            // ),
            // anchorPoint: Offset(0.5, 0.5),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return SingleChildScrollView(
                child: ProductDetails(
                    productId: widget.productModel.id,
                    slug: widget.productModel.slug),
              );
            });
      },
      child: Container(
        // padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).colorScheme.onPrimary
            // color: Theme.of(context).highlightColor,
            ),
            clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: CustomImageWidget(
                      image:
                          '${Provider.of<SplashController>(context, listen: false).baseUrls!.productThumbnailUrl}/${widget.productModel.thumbnail}',
                      height: MediaQuery.of(context).size.width / 1.9,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Off

                widget.productModel.discount! > 0
                    ? Positioned(
                        top: 10,
                        left: 0,
                        child: Container(
                          height: 20,
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeExtraSmall),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(
                                    Dimensions.paddingSizeExtraSmall),
                                bottomRight: Radius.circular(
                                    Dimensions.paddingSizeExtraSmall)),
                          ),
                          child: Center(
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                  PriceConverter.percentageCalculation(
                                      context,
                                      widget.productModel.unitPrice,
                                      widget.productModel.discount,
                                      widget.productModel.discountType),
                                  style: textRegular.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontSize: Dimensions.fontSizeSmall)),
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
                    productId: widget.productModel.id,
                  ),
                ),
              ],
            ),

            // Product Details
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.productModel.name ?? '',
                    style: textRegular.copyWith(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                          "${(widget.productModel.unitPrice! - (widget.productModel.discount ?? 0))} " +
                              " DA",
                          style: titilliumSemiBold.copyWith(
                              color: ColorResources.getPrimary(context))),
                      Spacer(),
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(Icons.star_rate_outlined,
                            color: Colors.orange, size: 20),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 0.50, end: 4),
                          child: Text(double.parse(ratting).toStringAsFixed(1),
                              style: textRegular.copyWith(
                                  fontSize: Dimensions.fontSizeDefault)),
                        ),
                        // Text('(${productModel.reviewCount.toString()})', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor))
                      ]),
                    ],
                  ),
                  if (widget.productModel.currentStock! == 0 &&
                      widget.productModel.productType == 'physical')
                    Text(getTranslated('out_of_stock', context) ?? '',
                        style: textRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFF36A6A))),
                  widget.productModel.discount != null &&
                          widget.productModel.discount! > 0
                      ? Text(
                          PriceConverter.convertPrice(
                              context, widget.productModel.unitPrice),
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
