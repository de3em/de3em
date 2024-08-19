import 'package:flutter/material.dart';
import 'package:da3em/features/category/domain/models/category_model.dart';
import 'package:da3em/localization/controllers/localization_controller.dart';
import 'package:da3em/features/splash/controllers/splash_controller.dart';
import 'package:da3em/utill/color_resources.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/common/basewidget/custom_image_widget.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel? category;
  final int index;
  final int length;
  const CategoryWidget({super.key, required this.category, required this.index, required this.length});

  @override
  Widget build(BuildContext context) {
    var baseController = Provider.of<SplashController>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(
        left: Provider.of<LocalizationController>(context, listen: false).isLtr ? Dimensions.homePagePadding : 0,
        right: index + 1 == length
            ? Dimensions.paddingSizeDefault
            : Provider.of<LocalizationController>(context, listen: false).isLtr
                ? 0
                : Dimensions.homePagePadding,
      ),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.width / 6,
            width: MediaQuery.of(context).size.width / 6,
            // decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.125), width: .25), borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall), color: Theme.of(context).primaryColor.withOpacity(.125)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CustomImageWidget(image: '${baseController.baseUrls?.categoryImageUrl}' '/${category?.icon}'),
            ),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeExtraSmall,
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 6.5,
              child: Text(
                category?.name ?? '',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                  color: ColorResources.getTextTitle(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
