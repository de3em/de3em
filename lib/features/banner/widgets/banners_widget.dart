import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:da3em/features/banner/controllers/banner_controller.dart';
import 'package:da3em/features/banner/widgets/banner_shimmer.dart';
import 'package:da3em/features/splash/controllers/splash_controller.dart';
import 'package:da3em/theme/controllers/theme_controller.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/common/basewidget/custom_image_widget.dart';
import 'package:provider/provider.dart';



class BannersWidget extends StatelessWidget {
  const BannersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        Consumer<BannerController>(
          builder: (context, bannerProvider, child) {

            double width = MediaQuery.of(context).size.width;
            return Stack(children: [
                // bannerProvider.mainBannerList != null ? 
                // bannerProvider.mainBannerList!.isNotEmpty ?
                if (bannerProvider.mainBannerList != null && bannerProvider.mainBannerList!.isNotEmpty)
                SizedBox(width: width,
                  child: Column(children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).primaryColor.withOpacity(.05),
                        ),
                        height: width * 0.33, width: width,
                        child: CarouselSlider.builder(
                          options: CarouselOptions(
                            aspectRatio: 4/1,
                            viewportFraction: 1,
                            autoPlay: true,
                            pauseAutoPlayOnTouch: true,
                            pauseAutoPlayOnManualNavigate: true,
                              pauseAutoPlayInFiniteScroll: true,
                            enlargeFactor: 0,
                            enlargeCenterPage: true,
                            disableCenter: true,
                            onPageChanged: (index, reason) {
                              Provider.of<BannerController>(context, listen: false).setCurrentIndex(index);}),
                          itemCount: bannerProvider.mainBannerList!.isEmpty ? 1 : bannerProvider.mainBannerList?.length,
                          itemBuilder: (context, index, _) {

                            return InkWell(
                              onTap: () {
                                if(bannerProvider.mainBannerList![index].resourceId != null){
                                  bannerProvider.clickBannerRedirect(context,
                                      bannerProvider.mainBannerList![index].resourceId,
                                      bannerProvider.mainBannerList![index].resourceType =='product'?
                                      bannerProvider.mainBannerList![index].product : null,
                                      bannerProvider.mainBannerList![index].resourceType);
                                }
                                },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: Container(decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                                  color: Provider.of<ThemeController>(context, listen: false).darkTheme?
                                  Theme.of(context).primaryColor.withOpacity(.1) :
                                  Theme.of(context).primaryColor.withOpacity(.05)),
                                    child: CustomImageWidget(image: '${Provider.of<SplashController>(context,listen: false).baseUrls?.bannerImageUrl}'
                                    '/${bannerProvider.mainBannerList?[index].photo}')
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                //  : const SizedBox() : const BannerShimmer(),

                if( bannerProvider.mainBannerList != null &&  bannerProvider.mainBannerList!.isNotEmpty)
                  Positioned(bottom: 5, left: 0, right: 0,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(height: 2, width: 20,
                      margin:  const EdgeInsets.symmetric(horizontal: 2.0),
                      decoration:  BoxDecoration(color: Colors.black.withOpacity(0.2),
                        // shape: BoxShape.circle,
                      ),
                    ),
                    if (false)
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: bannerProvider.mainBannerList!.map((banner) {
                            int index = bannerProvider.mainBannerList!.indexOf(banner);
                            return index == bannerProvider.currentIndex ? Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                              margin: const EdgeInsets.symmetric(horizontal: 6.0),
                              decoration: BoxDecoration(
                                color:  Theme.of(context).primaryColor ,
                                borderRadius: BorderRadius.circular(50)),
                              child:  Text("${bannerProvider.mainBannerList!.indexOf(banner) + 1}/ ${bannerProvider.mainBannerList!.length}",
                                style: const TextStyle(color: Colors.white,fontSize: 12),),
                            ):const SizedBox();
                          }).toList(),
                        ),
                      Container(height: 2, width: 20,
                        margin:  const EdgeInsets.symmetric(horizontal: 2.0),
                        decoration:  BoxDecoration(color: Colors.black.withOpacity(0.2),
                        ),
                      )
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 5),
      ],
    );
  }


}

