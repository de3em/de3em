import 'package:da3em/features/deal/domain/repositories/featured_deal_repository_interface.dart';
import 'package:da3em/features/deal/domain/services/featured_deal_service_interface.dart';

class FeaturedDealService implements FeaturedDealServiceInterface{
  FeaturedDealRepositoryInterface featuredDealRepositoryInterface;
  FeaturedDealService({required this.featuredDealRepositoryInterface});

  @override
  Future getFeaturedDeal() async{
    return await featuredDealRepositoryInterface.getFeaturedDeal();
  }

}