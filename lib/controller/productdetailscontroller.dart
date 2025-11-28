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
  // Cartcontroller cartcontroller = Get.put(Cartcontroller());
  late ItemsModel itemsModel;
  int countItems = 0;
  MyServices myServices = Get.find();

  CartData cartData = CartData(Get.find());

  late StatusRequest statusRequest;
  @override
  void onInit() {
    initialData();

    super.onInit();
  }

  addToCart(itemsid) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await cartData.addCart(
        myServices.sharedPrefrences.getString("id")!, itemsid.toString());
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      Get.rawSnackbar(
          title: "notification",
          backgroundColor: AppColor.primeColor,
          icon: const Icon(Icons.notifications_off_rounded),
          snackPosition: SnackPosition.TOP,
          messageText: const Text(
            "product add it to cart",
            style: TextStyle(color: Colors.white, fontFamily: "sans"),
          ));

      //  data.addAll(response['data']);
    }
    update();
  }

  removeFromCart(itemsid) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await cartData.removeCart(
        myServices.sharedPrefrences.getString("id")!, itemsid.toString());
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      Get.rawSnackbar(
          title: "notification",
          backgroundColor: AppColor.primeColor,
          snackPosition: SnackPosition.TOP,
          icon: const Icon(Icons.notifications_off_rounded),
          messageText: const Text("product removed it from cart",
              style: TextStyle(color: Colors.white, fontFamily: "sans")));

      //  data.addAll(response['data']);
    }
    update();
  }

  countitemsInCart(String itemsid) async {
    statusRequest = StatusRequest.loading;
    var response = await cartData.countitemsInCart(
        myServices.sharedPrefrences.getString("id")!, itemsid);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      // ✨ التعديل هنا: يتم استقبال القيمة كنص أولاً ثم تحويلها إلى عدد صحيح ✨
      String countItemsString = response['data'].toString();

      int countItems = int.tryParse(countItemsString) ?? 0;

      print("================================== $countItems");

      return countItems;
    } else {
      statusRequest = StatusRequest.failure;
      return 0; // يفضل إرجاع قيمة افتراضية عند الفشل
    }
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
