import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/services/sevices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;

  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPrefrences.getString("step") == "2") {
      return const RouteSettings(name: AppRoutes.homePage);
    }
    if (myServices.sharedPrefrences.getString("step") == "1") {
      return const RouteSettings(name: AppRoutes.login);
    }

    return null;
  }
}
