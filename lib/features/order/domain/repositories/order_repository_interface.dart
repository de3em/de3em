import 'package:da3em/interface/repo_interface.dart';

abstract class OrderRepositoryInterface<T> extends RepositoryInterface{

  Future<void> getOrderList(int offset, String status, {String? type});

  Future<dynamic> getTrackingInfo(String orderID);

  Future<dynamic> cancelOrder(int? orderId);


}