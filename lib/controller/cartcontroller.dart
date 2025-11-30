import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/class/functions/handlingdatacontroller.dart';
import 'package:ecommerce/core/services/sevices.dart';
import 'package:ecommerce/data/datasource/remote/cart.dart';
import 'package:ecommerce/data/model/cartmodel.dart';
import 'package:ecommerce/data/model/couponmodel.dart';
import 'package:ecommerce/data/model/itemsmodel.dart';
import 'package:flutter/material.dart'
import 'package:get/get.dart';

class Cartcontroller extends GetxController {
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  CartData cartData = CartData(Get.find());
  late String usersid = myServices.sharedPrefrences.getString("id")!;
  List<CartModel> data = [];
  CouponModel? couponModel;
  double priceorders = 0.0;
  double itemprice = 0.0;
  ItemsModel? itemsModel;
  int totalcountitems = 0;

///////////////coupon/////////////
  String? couponName;
  String? couponid;
  int coupondiscount = 0;
  TextEditingController? controllercoupon;
  ////////////////////////////

  addToCart(itemsid) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await cartData.addCart(
        myServices.sharedPrefrences.getString("id")!, itemsid.toString());
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        Get.rawSnackbar(
            title: "notification",
            icon: const Icon(Icons.notifications_off_rounded),
            messageText: const Text("product add it to cart"));
      }
    }
    update();
  }

  removeFromCart(itemsid) async {
// logic
  }

  countitemsInCart(String itemsid) async {
   //logic
  }

////////////////////couponcontroller////////////////////
  checkCoupon() async {
//
  }

  getTotalPrice() {
//
  }
  ///////////////////////////////////////////////

  viewCart() async {
/////////
  }

  resetVarCart() {
/////////
  }

  ///////////////
  @override
  void onInit() async {
    viewCart();
    controllercoupon = TextEditingController();
    super.onInit();
  }
}
