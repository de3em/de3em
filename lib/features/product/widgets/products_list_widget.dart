import 'package:flutter/material.dart';
import 'package:da3em/features/product/controllers/product_controller.dart';
import 'package:da3em/features/product/domain/models/product_model.dart';

import 'package:da3em/features/product/enums/product_type.dart';
import 'package:da3em/helper/responsive_helper.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/common/basewidget/no_internet_screen_widget.dart';
import 'package:da3em/common/basewidget/product_shimmer_widget.dart';
import 'package:da3em/common/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ProductListWidget extends StatelessWidget {
  final bool isHomePage;
  final ProductType productType;
  final ScrollController? scrollController;

  const ProductListWidget(
      {super.key,
      required this.isHomePage,
      required this.productType,
      this.scrollController});

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if (scrollController!.position.maxScrollExtent ==
              scrollController!.position.pixels &&
          Provider.of<ProductController>(context, listen: false)
              .latestProductList!
              .isNotEmpty &&
          !Provider.of<ProductController>(context, listen: false)
              .filterIsLoading) {
        late int pageSize;
        if (productType == ProductType.bestSelling ||
            productType == ProductType.topProduct ||
            productType == ProductType.newArrival ||
            productType == ProductType.discountedProduct ||
            productType == ProductType.featuredProduct) {
          if (productType == ProductType.featuredProduct) {
            pageSize = (Provider.of<ProductController>(context, listen: false)
                        .featuredPageSize! /
                    10)
                .ceil();
          } else {
            pageSize = (Provider.of<ProductController>(context, listen: false)
                        .latestPageSize! /
                    10)
                .ceil();
          }
          if (productType == ProductType.featuredProduct) {
            offset = Provider.of<ProductController>(context, listen: false)
                .lOffsetFeatured;
          } else {
            offset =
                Provider.of<ProductController>(context, listen: false).lOffset;
          }
        } else if (productType == ProductType.justForYou) {}
        if (offset < pageSize) {
          offset++;
          Provider.of<ProductController>(context, listen: false)
              .showBottomLoader();
          if (productType == ProductType.featuredProduct) {
            Provider.of<ProductController>(context, listen: false)
                .getFeaturedProductList(offset.toString());
          } else {
            Provider.of<ProductController>(context, listen: false)
                .getLatestProductList(offset);
          }
        } else {}
      }
    });

    return Consumer<ProductController>(
      builder: (context, prodProvider, child) {
        List<Product>? productList = [];
        if (productType == ProductType.latestProduct) {
          productList = prodProvider.lProductList;
        } else if (productType == ProductType.featuredProduct) {
          productList = prodProvider.featuredProductList;
        } else if (productType == ProductType.topProduct) {
          productList = prodProvider.latestProductList;
        } else if (productType == ProductType.bestSelling) {
          productList = prodProvider.latestProductList;
        } else if (productType == ProductType.newArrival) {
          productList = prodProvider.latestProductList;
        } else if (productType == ProductType.justForYou) {
          productList = prodProvider.justForYouProduct;
        }

        return Column(children: [
          !prodProvider.filterFirstLoading
              ? (productList != null && productList.isNotEmpty)
                  ? MasonryGridView.count(
                      itemCount: isHomePage
                          ? productList.length > 4
                              ? 4
                              : productList.length
                          : productList.length,
                      crossAxisCount: ResponsiveHelper.isTab(context) ? 4 : 2,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(4),
                          child:
                              ProductWidget(productModel: productList![index]),
                        );
                      },
                    )
                  : const NoInternetOrDataScreenWidget(isNoInternet: false)
              : ProductShimmer(
                  isHomePage: isHomePage, isEnabled: prodProvider.firstLoading),
          prodProvider.filterIsLoading
              ? Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor))),
              )
              : const SizedBox.shrink()
        ]);
      },
    );
  }
}
