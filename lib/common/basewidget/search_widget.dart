import 'package:flutter/material.dart';
import 'package:da3em/features/product/controllers/seller_product_controller.dart';
import 'package:da3em/localization/language_constrants.dart';
import 'package:da3em/utill/color_resources.dart';
import 'package:da3em/utill/custom_themes.dart';
import 'package:da3em/utill/dimensions.dart';
import 'package:da3em/utill/images.dart';
import 'package:da3em/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatefulWidget {
  final String? hintText;
  final int sellerId;
  const SearchWidget(
      {super.key, required this.hintText, required this.sellerId});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          child:
              SizedBox(height: 20, width: MediaQuery.of(context).size.width)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
              border: Border.all(
                  color: Theme.of(context).hintColor.withOpacity(.15))),
          child: Row(children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeExtraSmall,
                      horizontal: Dimensions.paddingSizeSmall),
                  child: TextFormField(
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    onFieldSubmitted: (val) {
                      Provider.of<SellerProductController>(context,
                              listen: false)
                          .getSellerProductList(
                              widget.sellerId.toString(), 1, "",
                              search: searchController.text.trim());
                    },
                    onChanged: (val) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      suffixIconConstraints:
                          const BoxConstraints(maxHeight: 25),
                      hintStyle: textRegular.copyWith(
                          color: Theme.of(context).hintColor),
                      border: InputBorder.none,
                      suffixIcon: searchController.text.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  searchController.clear();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 3.0),
                                child: Icon(Icons.clear,
                                    color: ColorResources.getChatIcon(context)),
                              ))
                          : const SizedBox(),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (searchController.text.trim().isEmpty) {
                  showCustomSnackBar(
                      getTranslated('enter_somethings', context), context);
                } else {
                  Provider.of<SellerProductController>(context, listen: false)
                      .getSellerProductList(widget.sellerId.toString(), 1, "",
                          search: searchController.text.trim());
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: 45,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(Dimensions.paddingSizeSmall))),
                  child: Image.asset(Images.search, color: Colors.white),
                ),
              ),
            )
          ]),
        ),
      ),
    ]);
  }
}
