import 'dart:io';

import 'package:da3em/features/profile/domain/models/profile_model.dart';
import 'package:da3em/interface/repo_interface.dart';

abstract class ProfileRepositoryInterface implements RepositoryInterface{

  Future<dynamic> getProfileInfo();
  Future<dynamic> updateProfile(ProfileModel userInfoModel, String pass, File? file, String token);
}