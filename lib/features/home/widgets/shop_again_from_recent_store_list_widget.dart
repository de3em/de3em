import 'package:flutter/material.dart';
import 'package:da3em/features/product/controllers/seller_product_controller.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/common/basewidget/custom_app_bar_widget.dart';
import 'package:da3em/features/home/widgets/shop_again_from_recent_store_widget.dart';
import 'package:provider/provider.dart';

class ShopAgainFromRecentStoreListWidget extends StatelessWidget {
  final bool isHome;
  const ShopAgainFromRecentStoreListWidget({super.key,  this.isHome = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('recent_store', context),),
      body: Consumer<SellerProductController>(
          builder: (context, shopAgainProvider,_) {
            return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: shopAgainProvider.shopAgainFromRecentStoreList.length,
                itemBuilder: (context, index) {
                  return ShopAgainFromRecentStoreWidget(shopAgainFromRecentStoreModel: shopAgainProvider.shopAgainFromRecentStoreList[index]);
                });
          }
      ),
    );
  }
}
