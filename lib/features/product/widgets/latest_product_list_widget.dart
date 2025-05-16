import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:da3em/common/basewidget/product_widget.dart';
import 'package:da3em/common/basewidget/slider_product_shimmer_widget.dart';
import 'package:da3em/features/product/controllers/product_controller.dart';
import 'package:da3em/features/product/screens/view_all_product_screen.dart';
import 'package:da3em/features/product/enums/product_type.dart';
import 'package:da3em/helper/responsive_helper.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/common/basewidget/title_row_widget.dart';
import 'package:provider/provider.dart';



class LatestProductListWidget extends StatelessWidget {
  const LatestProductListWidget({super.key});




  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(builder: (context, prodProvider, child) {
      return (prodProvider.latestProductList?.isNotEmpty ?? false)  ? Column( children: [
        TitleRowWidget(
          title: getTranslated('latest_products', context),
          onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => AllProductScreen(productType: ProductType.latestProduct))),
        ),

        const SizedBox(height: Dimensions.paddingSizeSmall),


        SizedBox(
          height: ResponsiveHelper.isTab(context)? MediaQuery.of(context).size.width * .58 : 320,
          child: CarouselSlider.builder(
            options: CarouselOptions(
              viewportFraction: ResponsiveHelper.isTab(context)? .5 :.65,
              autoPlay: false,
              pauseAutoPlayOnTouch: true,
              pauseAutoPlayOnManualNavigate: true,
              enlargeFactor: 0.2,
              enlargeCenterPage: true,
              pauseAutoPlayInFiniteScroll: true,
              disableCenter: true,
            ),
            itemCount: prodProvider.latestProductList?.length,
            itemBuilder: (context, index, next) {
              return ProductWidget(productModel: prodProvider.latestProductList![index], productNameLine: 1);
            },
          ),
        ),




      ]) : prodProvider.latestProductList == null ? const SliderProductShimmerWidget() : const SizedBox();
    });
  }
}

