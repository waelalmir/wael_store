import 'package:ecommerce/core/services/sevices.dart';
import 'package:get/get.dart';

translateDataBase(columnar, columnen) {
  MyServices myServices = Get.find();

  if (myServices.sharedPrefrences.getString("lang") == "ar") {
    return columnar;
  } else {
    return columnen;
  }
}
