import 'package:da3em/interface/repo_interface.dart';

abstract class SplashRepositoryInterface implements RepositoryInterface{

  Future<dynamic> getConfig();
  void initSharedData();
  String getCurrency();
  void setCurrency(String currencyCode);
  void disableIntro();
  bool? showIntro();
}