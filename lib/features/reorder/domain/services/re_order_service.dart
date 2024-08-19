import 'package:da3em/features/reorder/domain/repositories/re_order_repository_interface.dart';
import 'package:da3em/features/reorder/domain/services/re_order_service_interface.dart';

class ReOrderService implements ReOrderServiceInterface{
  ReOrderRepositoryInterface reOrderRepositoryInterface;
  ReOrderService({required this.reOrderRepositoryInterface});

  @override
  Future reorder(String orderId) async{
    return await reOrderRepositoryInterface.reorder(orderId);
  }
}