import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/data/model/itemsmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/class/functions/handlingdatacontroller.dart';
import '../core/services/sevices.dart';
import '../data/datasource/remote/cart.dart';

abstract class ProductDetailsController extends GetxController {}

class ProductDetailsControllerImp extends ProductDetailsController {
  late ItemsModel itemsModel;
  int countItems = 0;
  MyServices myServices = Get.find();

  CartData cartData = CartData(Get.find());

   StatusRequest statusRequest = StatusRequest.none;
  @override
  void onInit() {
    initialData();

    super.onInit();
  }

  addToCart(itemsid) async {
//
  }

  removeFromCart(itemsid) async {
//
  }

  countitemsInCart(String itemsid) async {
//
  }

  add() {
    addToCart(itemsModel.itemsId);
    countItems++;
    update();
  }

  goToCart() {
    Get.toNamed(AppRoutes.cart);
  }

  remove() {
    removeFromCart(itemsModel.itemsId);
    if (countItems > 0) {
      countItems--;
      update();
    }
  }

  initialData() async {
    statusRequest = StatusRequest.loading;
    itemsModel = Get.arguments['itemsModel'];
    countItems = await countitemsInCart(itemsModel.itemsId!);

    statusRequest = StatusRequest.success;
    update();
  }
}
