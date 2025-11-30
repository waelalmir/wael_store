import 'package:ecommerce/controller/auth/verifysignupcontroller.dart';
import 'package:ecommerce/core/class/handlingdataview.dart'; 
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/auth/customtextauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class Verifysignup extends StatelessWidget {
  const Verifysignup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VerifyCodeSignUpControllerImp());
    return Scaffold(
        appBar: AppBar(
          title: const Text("Verification"),
          centerTitle: true,
        ),
        body: GetBuilder<VerifyCodeSignUpControllerImp>(
          builder: (controller) => HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: ListView(children: [
                  const SizedBox(height: 20),
                  const CustomTextTitleAuth(
                    text2: "Check code",
                    text1: '',
                  ),
                  const SizedBox(height: 20),
                  Text(
                    textAlign: TextAlign.center,
                    "Please Enter The Digit Code Sent To ${controller.email}",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 15),
                  OtpTextField(
                    fieldWidth: 50.0,
                    borderRadius: BorderRadius.circular(20),
                    numberOfFields: 5,
                    borderColor: const Color(0xFF512DA8),
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {
                    },
                    onSubmit: (String verificationCode) {
                      controller.goToSuccessSignUp(verificationCode);
                    },
                  ),
                  const SizedBox(height: 40),
                  Container(
                    height: 40,
                    width: 50,
                    child: MaterialButton(
                      shape: Border.all(
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      minWidth: 45,
                      color: AppColor.primeColor,
                      onPressed: () {
                        controller.reSend();
                      },
                      child: Text(
                        "Resend code",
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("please check your spam if you dont recive code")
                ]),
              )),
        ));
  }
}
