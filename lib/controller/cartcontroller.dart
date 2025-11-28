import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/class/functions/handlingdatacontroller.dart';
import 'package:ecommerce/core/services/sevices.dart';
import 'package:ecommerce/data/datasource/remote/cart.dart';
import 'package:ecommerce/data/model/cartmodel.dart';
import 'package:ecommerce/data/model/couponmodel.dart';
import 'package:ecommerce/data/model/itemsmodel.dart';
import 'package:flutter/material.dart'
    show Icon, Icons, Text, TextEditingController;
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

        //  data.addAll(response['data']);
      }
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
          icon: const Icon(Icons.notifications_off_rounded),
          messageText: const Text("product removed it from cart"));

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
      int countItems = 0;
      countItems = response['data'];
      print("================================== $countItems");
      //  data.addAll(response['data']);
      return countItems;
    } else {
      statusRequest = StatusRequest.failure;
    }
  }

////////////////////couponcontroller////////////////////
  checkCoupon() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await cartData.couponDiscount(controllercoupon!.text);
    print("=============================== Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      Map<String, dynamic> dataCoupon = response['data'];
      couponModel = CouponModel.fromJson(dataCoupon);

      coupondiscount = int.parse(couponModel!.couponDiscount!.toString());
      couponName = couponModel!.couponName;
      couponid = couponModel!.couponId.toString();
    } else {
      Get.snackbar("Sorry", "Your coupon isn't valid");
    }
    update();
  }

  getTotalPrice() {
    double calculatedPrice = priceorders - priceorders * coupondiscount / 100;
    //toStringAsFixed =  just two number after .
    return calculatedPrice.toStringAsFixed(2);
  }
  ///////////////////////////////////////////////

  viewCart() async {
    statusRequest = StatusRequest.loading;

    data.clear();
    update();
    var response =
        await cartData.viewCart(myServices.sharedPrefrences.getString("id")!);
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response != null && response['datacart']['data'] != null) {
        data.clear();

        List dataresponse = response['datacart']['data'];
        Map dataresponsecountprice = response['countprice'];
        data.addAll(dataresponse.map((e) => CartModel.fromJson(e)));
        totalcountitems = int.parse(dataresponsecountprice['totalcount']);
        priceorders =
            double.parse(dataresponsecountprice['totalprice'].toString());
        if (data.isNotEmpty) {
          itemprice = double.parse(getTotalPrice().toString());
        } else {
          itemprice = 0.0;
        }
      }
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Oops", "Your cart is empty");
    }
    update();
  }

  resetVarCart() {
    priceorders = 0.0;
    totalcountitems = 0;
    data.clear();
  }

  refreshPage() {
    resetVarCart();
    viewCart();
  }

  goToCheckout() {
    if (data.isEmpty) {
      return Get.snackbar("sorry", "add  somthing to your cart its Empty");
    }
    Get.toNamed(AppRoutes.checkout, arguments: {
      "priceorders": priceorders.toString(),
      "couponid": couponid ?? "0",
      "coupondiscount": coupondiscount,
      "orderitemprice": itemprice.toString(),
    });
  }

  ///////////////
  @override
  void onInit() async {
    viewCart();
    controllercoupon = TextEditingController();
    super.onInit();
  }
}
