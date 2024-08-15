import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_shimmer_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class FeaturedProductWidget extends StatelessWidget {
  final ScrollController? scrollController;
  final bool isHome;

  const FeaturedProductWidget({super.key, this.scrollController, required this.isHome});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(
      builder: (context, prodProvider, child) {
        List<Product>? productList;
        productList = prodProvider.featuredProductList;
        return Stack(
          children: [
            Column( 
              children: [
                productList != null
                    ? productList.isNotEmpty
                        ? isHome
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10
                                ),
                                height: 300,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 10,
                                  itemBuilder: (context, index) => Container(
                                    width: 150,
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(start: 10),
                                      child: ProductWidget(
                                        productModel: productList![0],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : MasonryGridView.count(
                                itemCount: productList.length,
                                crossAxisCount: ResponsiveHelper.isTab(context) ? 3 : 2,
                                padding: const EdgeInsets.all(0),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) => ProductWidget(productModel: productList![index]),
                              )
                        : const SizedBox.shrink()
                    : ProductShimmer(isHomePage: true, isEnabled: prodProvider.firstFeaturedLoading),
                prodProvider.isFeaturedLoading
                    ? Center(
                        child: Padding(
                        padding: const EdgeInsets.all(Dimensions.iconSizeExtraSmall),
                        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
                      ))
                    : const SizedBox.shrink()
              ],
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: LinearPercentIndicator(
            //     padding: EdgeInsets.zero,
            //     barRadius: const Radius.circular(Dimensions.paddingSizeDefault),
            //     width: 80,
            //     lineHeight: 4.0,
            //     percent: prodProvider.featuredIndex / productList!.length,
            //     backgroundColor: Provider.of<ThemeController>(context, listen: false).darkTheme ? Theme.of(context).primaryColor.withOpacity(.7) : Theme.of(context).primaryColor.withOpacity(.2),
            //     progressColor: (Provider.of<ThemeController>(context, listen: false).darkTheme) ? Theme.of(context).colorScheme.onSecondary : Theme.of(context).primaryColor,
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
