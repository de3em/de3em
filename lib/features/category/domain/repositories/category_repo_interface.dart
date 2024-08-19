import 'package:da3em/interface/repo_interface.dart';

abstract class CategoryRepoInterface extends RepositoryInterface{
  Future<dynamic> getSellerWiseCategoryList(int sellerId);

}