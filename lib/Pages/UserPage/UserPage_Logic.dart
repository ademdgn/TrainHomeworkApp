import 'package:trackinghwapp/Storage_Service/Firebase_Storage.dart';
import 'package:flutter/material.dart';

import '../../Storage_Service/Firebase_Auth.dart';
import '../Const/Utils.dart';

class UserProfile {
  Storage storage = Storage();
  Auth auth = Auth();

  userProfilePhoto() async {
    return await storage.uploadProfilePhoto();
  }

  uploadPerson(Map<String, dynamic> updatedData) async {
    return await storage.updatePerson(updatedData);
  }

  Future<Map<String, dynamic>> getPerson() async {
    return await storage.getPerson();
  }

  logout() {
    auth.signOut();
  }

  changeEmail(String newEmail, String password, BuildContext context) {
    auth.changeEmail(newEmail, password);
  }

  changePassword(String newPassword) {
    auth.changePassword(newPassword);
  }
}
