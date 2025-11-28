import 'package:ecommerce/core/class/statusrequest.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/data/datasource/remote/auth/verifysignupdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// لا يوجد abstract class هنا، لا نحتاجه
abstract class VerifyCodeSignUpController extends GetxController {
  checkCode();
  goToSuccessSignUp(String verfiyCodeSignUp);
}

class VerifyCodeSignUpControllerImp extends VerifyCodeSignUpController {
  VerfiyCodeSignUpData verifySignupData = VerfiyCodeSignUpData(Get.find());

  String? email;
  StatusRequest statusRequest = StatusRequest.none;

  checkCode() {}

  goToSuccessSignUp(verfiyCodeSignUp) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await verifySignupData.postdata(email!, verfiyCodeSignUp);
    response.fold(
      (failure) {
        // Left -> خطأ
        print("❌ Failure: $failure");
        statusRequest = failure;
      },
      (data) {
        // Right -> Map
        print("✅ Data: $data");
        statusRequest = StatusRequest.success;

        if (data['status'] == "success") {
          Get.offNamed(AppRoutes.successsignup);
        } else {
          Get.defaultDialog(
              title: "Warning", middleText: "Verify Code Not Correct");
          statusRequest = StatusRequest.failure;
        }
      },
    );

    update();
  }

  reSend() {
    verifySignupData.resendData(email!);
    Get.rawSnackbar(
        backgroundColor: AppColor.primeColor,
        messageText: Text(
          "check your email inbox",
          style: TextStyle(color: Colors.white),
        ));
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    super.onInit();
  }
}
