import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/class/functions/handlingdatacontroller.dart';
import 'package:ecommerce/core/services/sevices.dart';
import 'package:ecommerce/data/datasource/remote/address.dart';
import 'package:ecommerce/data/datasource/remote/checkout_data.dart';
import 'package:ecommerce/data/model/addressmodel.dart';
import 'package:get/get.dart';

class Checkoutontroller extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  AddressData addressData = Get.put(AddressData(Get.find()));
  CheckoutData checkoutData = Get.put(CheckoutData(Get.find()));
  String? payMethod;
  String? addressid;
  String? ordersDiscount;

  late String priceorders;
  late String itemprice;
  late String couponid;

  List categories = [];
  List<AddressModel> data = [];
  choosePaymentMethod(String val) {
    payMethod = val;
    update();
  }

  chooseShippingAddress(String val) {
    addressid = val;
    update();
  }

  getShippingAddress() async {
//
  }

  checkOut() async {
//
  }

  paymentMethod(val) {
    payMethod = val;
    update();
  }

  address(val) {
    addressid = val.toString();
    update();
  }

  @override
  void onInit() {
    priceorders = Get.arguments['priceorders'];
    couponid = Get.arguments['couponid'];
    ordersDiscount = Get.arguments['coupondiscount'].toString();
    itemprice = Get.arguments['orderitemprice'].toString();
    getShippingAddress();
    super.onInit();
  }
}
