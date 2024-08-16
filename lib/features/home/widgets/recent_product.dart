import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_shimmer_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/data/localstorage/local_storage.dart';
import 'package:flutter_sixvalley_ecommerce/features/deal/widgets/featured_deal_card_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/aster_theme/find_what_you_need_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class RecentProductWidget extends StatelessWidget {
  final bool isHomePage;
  const RecentProductWidget({super.key, this.isHomePage = true});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecentProductProvider>(
        builder: (context, recentProductsController, child) {
      return CarouselSlider.builder(
        options: CarouselOptions(
          aspectRatio: 2.5,
          viewportFraction: 0.83,
          autoPlay: true,
          pauseAutoPlayOnTouch: true,
          pauseAutoPlayOnManualNavigate: true,
          pauseAutoPlayInFiniteScroll: true,
          enlargeFactor: 0.2,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
          disableCenter: true,
        ),
        itemCount: recentProductsController.recentProducts.length,
        itemBuilder: (context, index, _) => FeaturedDealWidget(
            isRecentProduct: true,
            isHomePage: isHomePage,
            product: recentProductsController.recentProducts[index]),
      );
    });
  }
}
