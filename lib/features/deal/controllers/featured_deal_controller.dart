import 'package:flutter/material.dart';
import 'package:da3em/data/model/api_response.dart';
import 'package:da3em/features/deal/domain/services/featured_deal_service_interface.dart';
import 'package:da3em/features/product/domain/models/product_model.dart';

import 'package:da3em/helper/api_checker.dart';

class FeaturedDealController extends ChangeNotifier {
  final FeaturedDealServiceInterface featuredDealServiceInterface;
  FeaturedDealController({required this.featuredDealServiceInterface});

  int? _featuredDealSelectedIndex;
  List<Product>? _featuredDealProductList;
  List<Product>? get featuredDealProductList =>_featuredDealProductList;
  int? get featuredDealSelectedIndex => _featuredDealSelectedIndex;


  Future<void> getFeaturedDealList(bool reload) async {
    _featuredDealProductList =[];
    //moh get list

      ApiResponse apiResponse = await featuredDealServiceInterface.getFeaturedDeal('35');
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200 && apiResponse.response!.data.toString() != '{}') {
        _featuredDealProductList =[];
        print(apiResponse.response!.data["data"]["products"]);
        apiResponse.response!.data["data"]["products"].forEach((key, products) =>
        products != null ?
            _featuredDealProductList?.add(Product.fromJson(products)) : null);
        _featuredDealSelectedIndex = 0;
      } else {
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();

  }

  void changeSelectedIndex(int selectedIndex) {
    _featuredDealSelectedIndex = selectedIndex;
    notifyListeners();
  }
}
