import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/class/functions/handlingdatacontroller.dart';
import 'package:ecommerce/core/services/sevices.dart';
import 'package:ecommerce/data/datasource/remote/address.dart';
import 'package:ecommerce/data/model/addressmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Addressviewcontroller extends GetxController {
  MyServices myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;

  AddressData addressData = AddressData(Get.find());

  late String usersid = myServices.sharedPrefrences.getString("id")!;

  List<AddressModel> data = [];


  viewAddress() async {
    statusRequest = StatusRequest.loading;
    update(); 

    var response = await addressData.viewAddress(usersid);
    print("=============================== Controller $response ");

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response != null && response['data'] != null) {
        List responseData = response['data'];
        data.addAll(responseData.map((e) => AddressModel.fromJson(e)).toList());
      } else {
        print(
            "Response data is null or empty, No address");
        if (data.isEmpty) {
          statusRequest = StatusRequest.success;
        }
      }
    }

    update();
  }

  deleteAddress(String addressid) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await addressData.deleteAdress(addressid);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      data.removeWhere(
          (element) => element.addressId.toString() == addressid.toString());

      Get.rawSnackbar(
        snackPosition: SnackPosition.TOP,
        title: "Address",
        messageText: Text(
          "Address deleted successfully",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColor.primeColor,
      );
    } else {
      Get.rawSnackbar(
        snackPosition: SnackPosition.TOP,
        title: "Error",
        messageText: Text(
          "Failed to delete address",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      );
    }

    update();
  }

  goToaddAdress() {
    Get.toNamed(AppRoutes.addressAdd);
  }

  @override
  void onInit() {
    viewAddress();
    super.onInit();
  }
}
