import 'package:ecommerce/core/constant/routes.dart';
import 'package:get/get.dart';

class SuccessSingUpController extends GetxController {
  goToLogin() {
    Get.offAllNamed(AppRoutes.login);
  }
}
