import 'package:da3em/interface/repo_interface.dart';

abstract class ShippingRepositoryInterface<T> implements RepositoryInterface{

  Future<dynamic> getShippingMethod(int? sellerId, String? type);

  Future<dynamic> addShippingMethod(int? id, String? cartGroupId);

  Future<dynamic> getChosenShippingMethod();

}