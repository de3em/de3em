import 'package:da3em/data/datasource/remote/dio/dio_client.dart';
import 'package:da3em/data/datasource/remote/exception/api_error_handler.dart';
import 'package:da3em/data/model/api_response.dart';
import 'package:da3em/features/shop/domain/repositories/shop_repository_interface.dart';
import 'package:da3em/utill/app_constants.dart';

class ShopRepository implements ShopRepositoryInterface{
  final DioClient? dioClient;
  ShopRepository({required this.dioClient});

  @override
  Future<ApiResponse> get(String sellerId) async {
    try {
      final response = await dioClient!.get("${AppConstants.sellerUri}$sellerId");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  @override
  Future<ApiResponse> getMoreStore() async {
    try {
      final response = await dioClient!.get(AppConstants.moreStore);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> getSellerList(String type, int offset) async {
    try {
      final response = await dioClient!.get("${AppConstants.sellerList}$type?limit=10&offset=$offset");
      print('======SellerResponce======>>${response.statusCode}');
      print('======SellerResponce======>>${offset}');
      print('======SellerResponce======>>${type}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print('======SellerResponce======>>${e}');
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future add(value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset = 1}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }

}