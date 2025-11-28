import 'package:ecommerce/controller/favoritecontroller.dart';
import 'package:ecommerce/controller/itemscontroller.dart';
import 'package:ecommerce/core/class/crud.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    // Get.lazyPut(() => LoginControllerImp());
    // Get.lazyPut(() => SignUpControllerImp());
    // Get.lazyPut(() => VerifySignUpControllerImp());
    Get.lazyPut(() => ItemscontrollerImp());
    Get.lazyPut(() => Favoritecontroller());
  }
}
