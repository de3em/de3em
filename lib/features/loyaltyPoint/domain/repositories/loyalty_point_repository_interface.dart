import 'package:da3em/interface/repo_interface.dart';

abstract class LoyaltyPointRepositoryInterface implements RepositoryInterface{
  Future<dynamic> convertPointToCurrency(int point);
}