import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:da3em/data/model/api_response.dart';
import 'package:da3em/features/shop/domain/models/more_store_model.dart';
import 'package:da3em/features/shop/domain/models/seller_info_model.dart';
import 'package:da3em/features/shop/domain/models/seller_model.dart';
import 'package:da3em/features/shop/domain/services/shop_service_interface.dart';
import 'package:da3em/helper/api_checker.dart';

import '../../../data/datasource/remote/dio/dio_client.dart';
import '../../../data/datasource/remote/exception/api_error_handler.dart';
import '../../../utill/app_constants.dart';
import '../../profile/controllers/profile_contrroller.dart';

class ShopController extends ChangeNotifier {
  final ShopServiceInterface? shopServiceInterface;
  final DioClient? dioClient;
  final ProfileController profile;
  ShopController( {required this.shopServiceInterface, required this.dioClient, required ProfileController this.profile});



  int shopMenuIndex = 0;
  void setMenuItemIndex(int index, {bool notify = true}){
    shopMenuIndex = index;
    if(notify){
      notifyListeners();
    }
  }


  SellerInfoModel? sellerInfoModel ;
  String? view_shop="0";
  bool? t_var;
  Future<ApiResponse> getSellerInfo(String sellerId) async {
    var kk = profile.userInfoModel?.id ?? '35';

    if(view_shop == '0') {

     dioClient!.post(
         AppConstants.m_point_action + '?userId=${kk}&storeId=' + sellerId +
             '&function=add_points&action=seen');
   }
    ApiResponse apiResponse = await shopServiceInterface!.get(sellerId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      sellerInfoModel = SellerInfoModel.fromJson(apiResponse.response!.data);

    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();

    try {

      Response response = await dioClient!.post(AppConstants.m_point_action + '?userId=${kk}&storeId='+sellerId+'&function=get_store_points&action=seen');
      view_shop=response.data['data'];
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }


  }



  bool isLoading = false;
  List<MostPopularStoreModel> moreStoreList =[];
  Future<ApiResponse> getMoreStore() async {
    moreStoreList = [];
    isLoading = true;
    ApiResponse apiResponse = await shopServiceInterface!.getMoreStore();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      apiResponse.response?.data.forEach((store)=> moreStoreList.add(MostPopularStoreModel.fromJson(store)));
    } else {
      isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }
  String sellerType = "top";
  String sellerTypeTitle = "top_seller";
  void setSellerType(String type, {bool notify = true}){
    sellerType = type;
    sellerModel = null;
    if(sellerType == "top"){
      sellerTypeTitle = "top_seller";
    }
    else if(sellerType == "new"){
      sellerTypeTitle = "new_seller";
    }else{
      sellerTypeTitle = "all_seller";
    }
    getTopSellerList(true, 1,type: sellerType);
    if(notify){
      notifyListeners();
    }
  }

  SellerModel? sellerModel;
  Future<void> getTopSellerList(bool reload, int offset, {required String type}) async {
      ApiResponse apiResponse = await shopServiceInterface!.getSellerList(type, offset);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        if(offset == 1){

          sellerModel = null;
          // SellerModel.fromJson(apiResponse.response?.data);
          sellerModel = SellerModel.fromJson(apiResponse.response?.data);


        }else{
          sellerModel?.sellers?.addAll(SellerModel.fromJson(apiResponse.response!.data).sellers??[]);
          sellerModel?.offset  = (SellerModel.fromJson(apiResponse.response!.data).offset!);
          sellerModel?.totalSize  = (SellerModel.fromJson(apiResponse.response!.data).totalSize!);
        }
      }
      notifyListeners();
  }

}
