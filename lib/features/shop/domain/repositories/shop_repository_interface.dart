import 'package:da3em/interface/repo_interface.dart';

abstract class ShopRepositoryInterface extends RepositoryInterface{
  Future<dynamic> getMoreStore();
  Future<dynamic> getSellerList(String type, int offset);
}