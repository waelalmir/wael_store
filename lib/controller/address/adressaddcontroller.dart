import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/class/functions/handlingdatacontroller.dart';
import 'package:ecommerce/core/services/sevices.dart';
import 'package:ecommerce/data/datasource/remote/address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Adressaddcontroller extends GetxController {
  MyServices myServices = Get.find();

  TextEditingController? city;
  TextEditingController? street;
  TextEditingController? name;

  String lat = "33.5138"; // مثال: خط عرض مدينة دمشق
  String long = "36.2765"; // مثال: خط طول مدينة دمشق

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;

  AddressData addressData = AddressData(Get.find());
  late String usersid = myServices.sharedPrefrences.getString("id")!;

  List data = [];

  initalData() {
    name = TextEditingController();
    city = TextEditingController();
    street = TextEditingController();

    lat = Get.arguments['lat'];
    long = Get.arguments['long'];

    print(lat);
    print(long);
  }

  addAddress() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await addressData.addAdress(
      city!.text,
      name!.text,
      street!.text,
      lat,
      long,
      usersid,
    );
    print("=============================== Controller $response ");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        if (response != null && response['data'] != null) {
          Get.rawSnackbar(
              title: "notification",
              icon: const Icon(Icons.notifications_off_rounded),
              messageText: const Text("product add it to cart"));

          //  data.addAll(response['data']);
        }
        // data.addAll(response['data']);
        Get.offAllNamed(
          AppRoutes.address,
        );
      } else {
        Get.defaultDialog(
            title: "ُWarning", middleText: "sorry the was an error !!!");
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    initalData();
    super.onInit();
  }
}
