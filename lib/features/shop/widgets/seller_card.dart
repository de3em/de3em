import 'package:flutter/material.dart';
import 'package:da3em/features/shop/domain/models/seller_model.dart';
import 'package:da3em/features/splash/controllers/splash_controller.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/localization/controllers/localization_controller.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/common/basewidget/custom_image_widget.dart';
import 'package:da3em/features/shop/screens/shop_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SellerCard extends StatefulWidget {
  final Seller? sellerModel;
  final bool isHomePage;
  final int index;
  final int length;
  const SellerCard(
      {super.key,
      this.sellerModel,
      this.isHomePage = false,
      required this.index,
      required this.length});

  @override
  State<SellerCard> createState() => _SellerCardState();
}

class _SellerCardState extends State<SellerCard> {
  bool vacationIsOn = false;
  @override
  Widget build(BuildContext context) {
    var splashController =
        Provider.of<SplashController>(context, listen: false);
    if (widget.sellerModel?.shop?.vacationEndDate != null) {
      DateTime vacationDate =
          DateTime.parse(widget.sellerModel!.shop!.vacationEndDate!);
      DateTime vacationStartDate =
          DateTime.parse(widget.sellerModel!.shop!.vacationStartDate!);
      final today = DateTime.now();
      final difference = vacationDate.difference(today).inDays;
      final startDate = vacationStartDate.difference(today).inDays;
      if (difference >= 0 &&
          widget.sellerModel!.shop!.vacationStatus! &&
          startDate <= 0) {
        vacationIsOn = true;
      } else {
        vacationIsOn = false;
      }
    }

    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => TopSellerProductScreen(
                        sellerId: widget.sellerModel?.id,
                        temporaryClose:
                            widget.sellerModel?.shop?.temporaryClose,
                        vacationStatus:
                            widget.sellerModel?.shop?.vacationStatus ?? false,
                        vacationEndDate:
                            widget.sellerModel?.shop?.vacationEndDate,
                        vacationStartDate:
                            widget.sellerModel?.shop?.vacationStartDate,
                        name: widget.sellerModel?.shop?.name,
                        banner: widget.sellerModel?.shop?.banner,
                        image: widget.sellerModel?.shop?.image,
                      )));
        },
        child: Padding(
          padding: widget.isHomePage
              ? EdgeInsets.only(
                  left: widget.index == 0
                      ? Dimensions.paddingSizeDefault
                      : Provider.of<LocalizationController>(context,
                                  listen: false)
                              .isLtr
                          ? Dimensions.paddingSizeDefault
                          : 0,
                  right: widget.index + 1 == widget.length
                      ? Dimensions.paddingSizeDefault
                      : (Provider.of<LocalizationController>(context,
                                      listen: false)
                                  .isLtr &&
                              widget.isHomePage)
                          ? 0
                          : Dimensions.paddingSizeDefault,
                  bottom: widget.isHomePage
                      ? Dimensions.paddingSizeExtraSmall
                      : Dimensions.paddingSizeDefault)
              : const EdgeInsets.fromLTRB(
                  Dimensions.paddingSizeSmall,
                  Dimensions.paddingSizeDefault,
                  Dimensions.paddingSizeSmall,
                  0),
          child: Container(
            clipBehavior: Clip.none,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).highlightColor.withOpacity(0.2),
            ),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                      height: widget.isHomePage ? 60 : 120,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          child: CustomImageWidget(
                              fit: BoxFit.cover,
                              image: widget.sellerModel!.id == 0
                                  ? splashController
                                          .configModel!.companyCoverImage ??
                                      ''
                                  : '${splashController.baseUrls!.shopImageUrl}/banner/${widget.sellerModel!.shop!.banner ?? ''}'))),
                ),

                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: 57,
                    width: 65,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.sellerModel?.shop?.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).hintColor,
                                fontWeight: FontWeight.bold)),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: Dimensions.paddingSizeExtraSmall),
                            child: Row(children: [
                              Text("Visit the Store >",
                                  style: textRegular.copyWith(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold))
                            ])),
                      ],
                    ),
                  ),
                )

                // Row(children: [
                //   Container(
                //       transform: Matrix4.translationValues(12, -20, 0),
                //       height: 60,
                //       width: 60,
                //       decoration: BoxDecoration(
                //         border: Border.all(width: 2, color: Colors.white),
                //         borderRadius: BorderRadius.circular(100),
                //         color: Theme.of(context).highlightColor,
                //       ),
                //       child: Stack(children: [
                //         Container(
                //             width: 60,
                //             height: 60,
                //             decoration: BoxDecoration(
                //                 borderRadius: const BorderRadius.all(
                //                     Radius.circular(
                //                         Dimensions.paddingSizeOverLarge)),
                //                 color: Theme.of(context).highlightColor),
                //             child: ClipRRect(
                //                 borderRadius: const BorderRadius.all(
                //                     Radius.circular(
                //                         Dimensions.paddingSizeOverLarge)),
                //                 child: CustomImageWidget(
                //                     image: widget.sellerModel!.id == 0
                //                         ? splashController
                //                                 .configModel!.companyIcon ??
                //                             ''
                //                         : '${splashController.baseUrls!.shopImageUrl!}/${widget.sellerModel!.shop?.image}',
                //                     width: 60,
                //                     height: 60))),
                //         if ((widget.sellerModel!.shop!.temporaryClose ??
                //                 false) ||
                //             vacationIsOn)
                //           Container(
                //               decoration: BoxDecoration(
                //                   color: Colors.black.withOpacity(.5),
                //                   borderRadius: const BorderRadius.all(
                //                       Radius.circular(
                //                           Dimensions.paddingSizeOverLarge)))),
                //         (widget.sellerModel!.shop!.temporaryClose ?? false)
                //             ? Center(
                //                 child: Text(
                //                     getTranslated('temporary_closed', context)!,
                //                     textAlign: TextAlign.center,
                //                     style: textRegular.copyWith(
                //                         color: Colors.white,
                //                         fontSize: Dimensions.fontSizeSmall)))
                //             : vacationIsOn == true
                //                 ? Center(
                //                     child: Text(
                //                     getTranslated('close_for_now', context)!,
                //                     textAlign: TextAlign.center,
                //                     style: textRegular.copyWith(
                //                         color: Colors.white,
                //                         fontSize: Dimensions.fontSizeSmall),
                //                   ))
                //                 : const SizedBox()
                //       ])),
                //   const SizedBox(width: Dimensions.paddingSizeLarge),
                //   Expanded(
                //       child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //         Text(
                //           widget.sellerModel?.shop?.name ?? '',
                //           maxLines: 1,
                //           overflow: TextOverflow.ellipsis,
                //           style: textRegular.copyWith(
                //               fontSize: Dimensions.fontSizeLarge),
                //         ),
                //         Padding(
                //             padding: const EdgeInsets.only(
                //                 top: Dimensions.paddingSizeExtraSmall),
                //             child: Row(children: [
                //               Icon(
                //                 Icons.star_rate_rounded,
                //                 color: Colors.yellow.shade700,
                //                 size: 15,
                //               ),
                //               Text(
                //                 "${widget.sellerModel?.averageRating?.toStringAsFixed(1)} ",
                //                 style: textRegular.copyWith(
                //                     fontSize: Dimensions.fontSizeSmall),
                //               ),
                //               Text(
                //                 " (${widget.sellerModel?.ratingCount ?? 0})",
                //                 style: textRegular.copyWith(
                //                     fontSize: Dimensions.fontSizeSmall,
                //                     color: Theme.of(context).hintColor),
                //               ),
                //             ]))
                //       ]))
                // ]),
                // Padding(
                //     padding: const EdgeInsets.only(
                //         left: Dimensions.paddingSizeSmall,
                //         right: Dimensions.paddingSizeSmall,
                //         bottom: Dimensions.paddingSizeSmall),
                //     child: Row(children: [
                //       Expanded(
                //           child: Container(
                //               padding: const EdgeInsets.all(
                //                   Dimensions.paddingSizeExtraSmall),
                //               decoration: BoxDecoration(
                //                   color: Theme.of(context)
                //                       .hintColor
                //                       .withOpacity(.125),
                //                   borderRadius: BorderRadius.circular(
                //                       Dimensions.paddingSizeExtraSmall)),
                //               child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   children: [
                //                     Text(
                //                       NumberFormat.compact().format(
                //                           widget.sellerModel?.productCount ??
                //                               0),
                //                       style: textBold.copyWith(
                //                           fontSize: Dimensions.fontSizeDefault,
                //                           color:
                //                               Theme.of(context).primaryColor),
                //                     ),
                //                     const SizedBox(
                //                         width:
                //                             Dimensions.paddingSizeExtraSmall),
                //                     Text(
                //                         "${getTranslated('products', context)}",
                //                         style: textBold.copyWith(
                //                             fontSize: Dimensions.fontSizeSmall))
                //                   ])))
                //     ])),
              ],
            ),
          ),
        ));
  }
}
