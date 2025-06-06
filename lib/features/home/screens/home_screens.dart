import 'package:flutter/material.dart';
import 'package:da3em/data/localstorage/local_storage.dart';
import 'package:da3em/features/address/controllers/address_controller.dart';
import 'package:da3em/features/deal/controllers/featured_deal_controller.dart';
import 'package:da3em/features/deal/controllers/flash_deal_controller.dart';
import 'package:da3em/features/home/widgets/recent_product.dart';
import 'package:da3em/features/product/controllers/product_controller.dart';
import 'package:da3em/features/product/screens/view_all_product_screen.dart';
import 'package:da3em/features/product/widgets/featured_product_widget.dart';
import 'package:da3em/features/product/widgets/home_category_product_widget.dart';
import 'package:da3em/features/product/widgets/latest_product_list_widget.dart';
import 'package:da3em/features/product/widgets/products_list_widget.dart';
import 'package:da3em/features/product/widgets/recommended_product_widget.dart';
import 'package:da3em/features/profile/controllers/profile_contrroller.dart';
import 'package:da3em/features/search_product/screens/search_product_screen.dart';
import 'package:da3em/features/shop/controllers/shop_controller.dart';
import 'package:da3em/features/product/enums/product_type.dart';
import 'package:da3em/features/wishlist/controllers/wishlist_controller.dart';
import 'package:da3em/helper/responsive_helper.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/main.dart';
import 'package:da3em/features/auth/controllers/auth_controller.dart';
import 'package:da3em/features/banner/controllers/banner_controller.dart';
import 'package:da3em/features/brand/controllers/brand_controller.dart';
import 'package:da3em/features/cart/controllers/cart_controller.dart';
import 'package:da3em/features/category/controllers/category_controller.dart';
import 'package:da3em/features/notification/controllers/notification_controller.dart';
import 'package:da3em/features/splash/controllers/splash_controller.dart';
import 'package:da3em/theme/controllers/theme_controller.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:da3em/common/basewidget/title_row_widget.dart';
import 'package:da3em/features/brand/screens/brands_screen.dart';
import 'package:da3em/features/category/screens/category_screen.dart';
import 'package:da3em/features/deal/screens/featured_deal_screen_view.dart';
import 'package:da3em/features/home/shimmers/featured_product_shimmer.dart';
import 'package:da3em/features/home/widgets/announcement_widget.dart';
import 'package:da3em/features/home/widgets/aster_theme/find_what_you_need_shimmer.dart';
import 'package:da3em/features/banner/widgets/banners_widget.dart';
import 'package:da3em/features/brand/widgets/brand_list_widget.dart';
import 'package:da3em/features/home/widgets/cart_home_page_widget.dart';
import 'package:da3em/features/category/widgets/category_list_widget.dart';
import 'package:da3em/features/deal/widgets/featured_deal_list_widget.dart';
import 'package:da3em/features/home/shimmers/flash_deal_shimmer.dart';
import 'package:da3em/features/deal/widgets/flash_deals_list_widget.dart';
import 'package:da3em/features/banner/widgets/single_banner_widget.dart';
import 'package:da3em/features/deal/screens/flash_deal_screen_view.dart';
import 'package:da3em/features/home/widgets/search_home_page_widget.dart';
import 'package:da3em/features/shop/widgets/top_seller_view.dart';
import 'package:da3em/features/shop/screens/all_shop_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  Future<void> _loadData(bool reload) async {
    await Provider.of<ShopController>(Get.context!, listen: false).getTopSellerList(reload, 1, type: "top");
    await Provider.of<BannerController>(Get.context!, listen: false).getBannerList(reload);
    // Provider.of<BannerController>(Get.context!, listen: false).getBannerList(reload);
    await Provider.of<CategoryController>(Get.context!, listen: false).getCategoryList(reload);
    // Provider.of<AddressController>(context, listen: false).getAddressList();
    await Provider.of<ProductController>(Get.context!, listen: false).getHomeCategoryProductList(reload);
    await Provider.of<BrandController>(Get.context!, listen: false).getBrandList(reload);
    await Provider.of<ProductController>(Get.context!, listen: false).getLatestProductList(1, reload: reload);
    await Provider.of<ProductController>(Get.context!, listen: false).getFeaturedProductList('1', reload: reload);
    await Provider.of<FeaturedDealController>(Get.context!, listen: false).getFeaturedDealList(reload);
    await Provider.of<ProductController>(Get.context!, listen: false).getLProductList('1', reload: reload);
    await Provider.of<ProductController>(Get.context!, listen: false).getRecommendedProduct();
    await Provider.of<CartController>(Get.context!, listen: false).getCartData(Get.context!);
    await Provider.of<NotificationController>(Get.context!, listen: false).getNotificationList(1);
    if (Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn()) {
      await Provider.of<ProfileController>(Get.context!, listen: false).getUserInfo(Get.context!);
      await Provider.of<WishListController>(Get.context!, listen: false).getWishList();
    }
  }

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  bool singleVendor = false;
  @override
  void initState() {
    super.initState();
    singleVendor = Provider.of<SplashController>(context, listen: false).configModel!.businessMode == "single";
    Provider.of<FlashDealController>(context, listen: false).getFlashDealList(true, true);
    _loadData(false);
  }

  @override
  Widget build(BuildContext context) {
    List<String?> types = [
      getTranslated('new_arrival', context),
      getTranslated('top_product', context),
      getTranslated('best_selling', context),
      getTranslated('discounted_product', context)
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await _loadData(true);
            await Provider.of<FlashDealController>(Get.context!, listen: false).getFlashDealList(true, false);
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(floating: true, elevation: 0, centerTitle: false, automaticallyImplyLeading: false, backgroundColor: Colors.white, title: Image.asset(Images.logoWithNameImage, height: 35), actions: const [
                CartHomePageWidget()
              ]),
              SliverToBoxAdapter(
                child: Consumer<SplashController>(builder: (context, announcement, _) {
                  return (announcement.configModel!.announcement!.announcement != null && announcement.onOff) ? AnnouncementWidget(announcement: announcement.configModel!.announcement) : const SizedBox();
                }),
              ),
              // SliverPersistentHeader(
              //     pinned: true,
              //     delegate: SliverDelegate(
              //         child: InkWell(
              //             onTap: () => Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (_) => const SearchScreen())),
              //             child: const SearchHomePageWidget()))),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BannersWidget(),
                    // const SizedBox(height: Dimensions.homePagePadding),

                    Consumer<FlashDealController>(
                      builder: (context, megaDeal, child) {
                        return megaDeal.flashDeal != null
                            ? megaDeal.flashDealList.isNotEmpty
                                ? Column(children: [
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(Dimensions.homePagePadding, Dimensions.paddingSizeSmall, Dimensions.paddingSizeDefault, Dimensions.paddingSizeExtraExtraSmall),
                                        child: TitleRowWidget(
                                            title: getTranslated('flash_deal', context),
                                            eventDuration: megaDeal.flashDeal != null ? megaDeal.duration : null,
                                            onTap: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (_) => const FlashDealScreenView()));
                                            },
                                            isFlash: true)),
                                    const SizedBox(height: Dimensions.paddingSizeSmall),
                                    Text(getTranslated('hurry_up_the_offer_is_limited_grab_while_it_lasts', context) ?? '', style: textRegular.copyWith(color: Provider.of<ThemeController>(context, listen: false).darkTheme ? Theme.of(context).hintColor : Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeDefault)),
                                    const SizedBox(height: Dimensions.paddingSizeDefault),
                                    SizedBox(height: ResponsiveHelper.isTab(context) ? MediaQuery.of(context).size.width * .58 : 350, child: const Padding(padding: EdgeInsets.only(bottom: Dimensions.homePagePadding), child: FlashDealsListWidget()))
                                  ])
                                : const SizedBox.shrink()
                            : const FlashDealShimmer();
                      },
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraExtraSmall, vertical: Dimensions.paddingSizeExtraSmall),
                    //   child: TitleRowWidget(
                    //     title: getTranslated('CATEGORY', context),
                    //     onTap: () => Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (_) => const CategoryScreen(),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    const CategoryListWidget(isHomePage: true),
                    Provider.of<SplashController>(context, listen: false).configModel!.brandSetting == "1" ? TitleRowWidget(title: getTranslated('brand', context), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BrandsView()))) : const SizedBox(),
                    SizedBox(height: Provider.of<SplashController>(context, listen: false).configModel!.brandSetting == "1" ? Dimensions.paddingSizeSmall : 0),
                    Provider.of<SplashController>(context, listen: false).configModel!.brandSetting == "1" ? const BrandListWidget(isHomePage: true) : const SizedBox(),
                    Consumer<FeaturedDealController>(
                      builder: (context, featuredDealProvider, child) {
                        return featuredDealProvider.featuredDealProductList != null
                            ? featuredDealProvider.featuredDealProductList!.isNotEmpty
                                ? Stack(children: [
                                    Container(width: MediaQuery.of(context).size.width, height: 150, color: Provider.of<ThemeController>(context, listen: false).darkTheme ? Theme.of(context).primaryColor.withOpacity(.20) : Theme.of(context).primaryColor.withOpacity(.125)),
                                    Padding(
                                        padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding),
                                        child: Column(children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                                            child: TitleRowWidget(
                                              title: '${getTranslated('featured_deals', context)}',
                                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FeaturedDealScreenView())),
                                            ),
                                          ),
                                          const FeaturedDealsListWidget()
                                        ])),
                                  ])
                                : const SizedBox.shrink()
                            : const FindWhatYouNeedShimmer();
                      },
                    ),

                    Consumer<BannerController>(builder: (context, footerBannerProvider, child) {
                      return footerBannerProvider.footerBannerList != null && footerBannerProvider.footerBannerList!.isNotEmpty ? Padding(padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding, left: Dimensions.homePagePadding, right: Dimensions.homePagePadding), child: SingleBannersWidget(bannerModel: footerBannerProvider.footerBannerList?[0])) : const SizedBox();
                    }),
                    if (Provider.of<RecentProductProvider>(context).recentProducts.isNotEmpty)
                      Container(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                        child: Consumer<RecentProductProvider>(builder: (context, recentProductProvider, _) {
                          return Stack(children: [
                            // Padding(
                            //     padding: const EdgeInsets.only(bottom: 25),
                            //     child: Container(
                            //       width: MediaQuery.of(context).size.width,
                            //       height: ResponsiveHelper.isTab(context) ? MediaQuery.of(context).size.width / 2 : MediaQuery.of(context).size.width - 50,
                            //       decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.paddingSizeDefault), bottomLeft: Radius.circular(Dimensions.paddingSizeDefault)), color: Theme.of(context).colorScheme.onSecondaryContainer),
                            //     )),
                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 12, bottom: 12),
                                child: TitleRowWidget(
                                  title: "Recently Viewed",
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AllProductScreen(productType: ProductType.featuredProduct),
                                    ),
                                  ),
                                ),
                              ),
                              RecentProductWidget(scrollController: _scrollController, isHome: true),
                            ])
                          ]);
                        }),
                      ),
                    Consumer<BannerController>(builder: (context, footerBannerProvider, child) {
                      return footerBannerProvider.footerBannerList != null && footerBannerProvider.footerBannerList!.length > 1 ? SingleBannersWidget(bannerModel: footerBannerProvider.footerBannerList?[1]) : const SizedBox();
                    }),
                    const SizedBox(height: Dimensions.homePagePadding),

                    Consumer<ProductController>(builder: (context, featured, _) {
                      return featured.featuredProductList != null
                          ? featured.featuredProductList!.isNotEmpty
                              ? Stack(children: [
                                  // Padding(
                                  //     padding: const EdgeInsets.only(bottom: 25),
                                  //     child: Container(
                                  //       width: MediaQuery.of(context).size.width,
                                  //       height: ResponsiveHelper.isTab(context) ? MediaQuery.of(context).size.width / 2 : MediaQuery.of(context).size.width - 50,
                                  //       decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.paddingSizeDefault), bottomLeft: Radius.circular(Dimensions.paddingSizeDefault)), color: Theme.of(context).colorScheme.onSecondaryContainer),
                                  //     )),
                                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                                      child: TitleRowWidget(
                                        title: getTranslated('featured_products', context),
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => AllProductScreen(productType: ProductType.featuredProduct),
                                          ),
                                        ),
                                      ),
                                    ),
                                    FeaturedProductWidget(scrollController: _scrollController, isHome: true),
                                  ])
                                ])
                              : const SizedBox()
                          : const FeaturedProductShimmer();
                    }),




                    singleVendor
                        ? const SizedBox()
                        : Consumer<ShopController>(builder: (context, topSellerProvider, child) {
                            return (topSellerProvider.sellerModel != null && (topSellerProvider.sellerModel!.sellers != null && topSellerProvider.sellerModel!.sellers!.isNotEmpty))
                                ? TitleRowWidget(
                                    title: getTranslated('top_seller', context),
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const AllTopSellerScreen(
                                                  title: 'top_stores',
                                                ))))
                                : const SizedBox();
                          }),
                    singleVendor ? const SizedBox(height: 0) : const SizedBox(height: Dimensions.paddingSizeSmall),

                    singleVendor
                        ? const SizedBox()
                        : Consumer<ShopController>(builder: (context, topSellerProvider, child) {
                            return (topSellerProvider.sellerModel != null && (topSellerProvider.sellerModel!.sellers != null && topSellerProvider.sellerModel!.sellers!.isNotEmpty))
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: Dimensions.homePagePadding),
                                    child: SizedBox(
                                        height: ResponsiveHelper.isTab(context) ? 170 : 63,
                                        child: TopSellerView(
                                          isHomePage: true,
                                          scrollController: _scrollController,
                                        )))
                                : const SizedBox();
                          }),




                    const Padding(padding: EdgeInsets.only(bottom: Dimensions.homePagePadding), child: RecommendedProductWidget()),
                    const Padding(padding: EdgeInsets.only(bottom: Dimensions.paddingSizeSmall), child: LatestProductListWidget()),



                    const HomeCategoryProductWidget(isHomePage: true),
                    Consumer<ProductController>(builder: (ctx, prodProvider, child) {
                      return Container(
                          decoration: BoxDecoration(
                              // color: Theme.of(context).colorScheme.primary
                              ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeSmall, 0),
                                child: Row(children: [
                                  Expanded(child: Text(prodProvider.title == 'xyz' ? getTranslated('new_arrival', context)! : prodProvider.title!, style: titleHeader)),
                                  prodProvider.latestProductList != null
                                      ? PopupMenuButton(
                                          itemBuilder: (context) {
                                            return [
                                              PopupMenuItem(value: ProductType.newArrival, textStyle: textRegular.copyWith(color: Theme.of(context).hintColor), child: Text(getTranslated('new_arrival', context) ?? '')),
                                              PopupMenuItem(value: ProductType.topProduct, textStyle: textRegular.copyWith(color: Theme.of(context).hintColor), child: Text(getTranslated('top_product', context) ?? '')),
                                              PopupMenuItem(value: ProductType.bestSelling, textStyle: textRegular.copyWith(color: Theme.of(context).hintColor), child: Text(getTranslated('best_selling', context) ?? '')),
                                              PopupMenuItem(value: ProductType.discountedProduct, textStyle: textRegular.copyWith(color: Theme.of(context).hintColor), child: Text(getTranslated('discounted_product', context) ?? ''))
                                            ];
                                          },
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
                                          child: Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeExtraSmall, Dimensions.paddingSizeSmall, Dimensions.paddingSizeExtraSmall, Dimensions.paddingSizeSmall), child: Image.asset(Images.dropdown, scale: 3)),
                                          onSelected: (dynamic value) {
                                            if (value == ProductType.newArrival) {
                                              Provider.of<ProductController>(context, listen: false).changeTypeOfProduct(value, types[0]);
                                            } else if (value == ProductType.topProduct) {
                                              Provider.of<ProductController>(context, listen: false).changeTypeOfProduct(value, types[1]);
                                            } else if (value == ProductType.bestSelling) {
                                              Provider.of<ProductController>(context, listen: false).changeTypeOfProduct(value, types[2]);
                                            } else if (value == ProductType.discountedProduct) {
                                              Provider.of<ProductController>(context, listen: false).changeTypeOfProduct(value, types[3]);
                                            }
                                            ProductListWidget(isHomePage: false, productType: value, scrollController: _scrollController);
                                            Provider.of<ProductController>(context, listen: false).getLatestProductList(1, reload: true);
                                          })
                                      : const SizedBox()
                                ])),
                            ProductListWidget(isHomePage: false, productType: ProductType.newArrival, scrollController: _scrollController),
                            const SizedBox(height: Dimensions.homePagePadding)
                          ]));
                    }),
                    const SizedBox(height: Dimensions.homePagePadding),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;
  SliverDelegate({required this.child, this.height = 70});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height || oldDelegate.minExtent != height || child != oldDelegate.child;
  }
}
