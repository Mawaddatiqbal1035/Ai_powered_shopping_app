
import 'package:ai_powered_shopping/core/share_service/firebase_authentication.dart';
import 'package:get/get.dart';

class AuthenticationDepdendencyInjection extends Bindings{

  @override
  void dependencies() {
    Get.put(FirebaseAuthentication());
    // TODO: implement dependencies
  }
}