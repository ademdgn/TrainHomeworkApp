import 'package:trackinghwapp/Storage_Service/Firebase_Storage.dart';

class HomeController {
  Storage storage = Storage();

  Future<Map<String, dynamic>> getPerson() async {
    return await storage.getPerson();
  }
}
