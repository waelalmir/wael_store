import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/class/functions/handlingdatacontroller.dart';
import 'package:ecommerce/data/datasource/remote/forgetpassword/verifycode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class VerifyCodeController extends GetxController {
  checkcode() {}
  gotoresetpassword(String verifyCode) {}
}

class VerifyCodeControllerImp extends VerifyCodeController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.none;
  VerifyCodeData verifyCodeData = VerifyCodeData(Get.find());
  String? email;
  late String verifycode;
  @override
  checkcode() async {}

  @override
  gotoresetpassword(String verifyCode) async {
    if (formstate.currentState?.validate() ?? true) {
      if (email == null) {
        Get.defaultDialog(title: "Error", middleText: "Email is missing!");
        return;
      }
      statusRequest = StatusRequest.loading;
      update();

      var response = await verifyCodeData.postData(email!, verifyCode);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          Get.offNamed(AppRoutes.resetPassowrd, arguments: {"email": email});
        } else {
          Get.defaultDialog(
              title: "Warning", middleText: "Verify code is not correct");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
  }
}
