import 'package:da3em/features/splash/domain/repositories/splash_repository_interface.dart';
import 'package:da3em/features/splash/domain/services/splash_service_interface.dart';

class SplashService implements SplashServiceInterface{
  SplashRepositoryInterface splashRepositoryInterface;

  SplashService({required this.splashRepositoryInterface});

  @override
  void disableIntro() {
    return splashRepositoryInterface.disableIntro();
  }

  @override
  Future getConfig() {
    return splashRepositoryInterface.getConfig();
  }

  @override
  String getCurrency() {
    return splashRepositoryInterface.getCurrency();
  }

  @override
  void initSharedData() {
    return splashRepositoryInterface.initSharedData();
  }

  @override
  void setCurrency(String currencyCode) {
    return splashRepositoryInterface.setCurrency(currencyCode);
  }

  @override
  bool? showIntro() {
    return splashRepositoryInterface.showIntro();
  }

}