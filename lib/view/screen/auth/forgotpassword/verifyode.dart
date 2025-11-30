import 'package:ecommerce/controller/forgetpassword/verifycodecontroller.dart';
import 'package:ecommerce/core/class/handlingdataview.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/shared/customappbar.dart';
import 'package:ecommerce/view/widget/auth/customtextauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerifyCodeControllerImp());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Customappbar(title: "Verify Code".tr),
      body: GetBuilder<VerifyCodeControllerImp>(
        builder: (controller) {
          return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 10),

                  CustomTextTitleAuth(
                    text1: "",
                    text2: "Enter the 5-digit code sent to your email".tr,
                  ),

                  const SizedBox(height: 25),

                  OtpTextField(
                    numberOfFields: 5,
                    fieldHeight: 58,
                    fieldWidth: 52,
                    borderRadius: BorderRadius.circular(12),
                    showFieldAsBox: true,
                    borderWidth: 1.4,
                    enabledBorderColor: AppColor.thirdColor.withOpacity(.4),
                    focusedBorderColor: AppColor.primeColor,
                    cursorColor: AppColor.primeColor,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    onCodeChanged: (String code) {},
                    onSubmit: (String verificationCode) {
                      controller.gotoresetpassword(verificationCode);
                    },
                  ),

                  const SizedBox(height: 30),

                  // Center(
                  //   child: TextButton(
                  //     onPressed: () {
                  //       controller.reSend();
                  //     },
                  //     child: Text(
                  //       "Resend Code",
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         color: AppColor.primeColor,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
