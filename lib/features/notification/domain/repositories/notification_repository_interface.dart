import 'package:da3em/interface/repo_interface.dart';

abstract class NotificationRepositoryInterface implements RepositoryInterface{
  Future<dynamic>  seenNotification(int id);

}