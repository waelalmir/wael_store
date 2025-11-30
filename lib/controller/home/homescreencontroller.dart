import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/view/screen/home/home.dart';
import 'package:ecommerce/view/screen/product/myfavorite.dart';
import 'package:ecommerce/view/screen/orders/orders.dart';
import 'package:ecommerce/view/screen/global/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class Homescreencontroller extends GetxController {
  changePage(int currentpage) {}
  goToCart() {}
}

class HomeScreenControllerImp extends Homescreencontroller {
  int currentPage = 0;
  List<Widget> listPage = [
    const HomePage(),
    const Settings(),
    const MyFavorite(),
    const Orders(),
  ];

  List listNameOfPages = [
    "home".tr,
    "setting".tr,
    "favorite".tr,
    "orders".tr,
  ];

  List<IconData> listIconsOfPages = [
    Icons.home, 
    Icons.settings, 
    Icons.favorite, 
    Icons.person, 
  ];

  @override
  changePage(int i) {
    currentPage = i;
    update();
  }

  goToCart() {
    Get.toNamed(AppRoutes.cart);
  }
}
