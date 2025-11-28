import 'package:ecommerce/view/screen/auth/login.dart';
import 'package:get/get.dart';

class SuccessResetPasswordImp extends GetxController {
  gotoLogin() {
    Get.off(Login());
  }
}
