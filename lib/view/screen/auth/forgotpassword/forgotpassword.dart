import 'package:ecommerce/controller/forgetpassword/forgotpasswordcontroller.dart';
import 'package:ecommerce/core/class/handlingdataview.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/shared/customappbar.dart';
import 'package:ecommerce/view/widget/auth/custombuttonauth.dart';
import 'package:ecommerce/view/widget/auth/customtextauth.dart';
import 'package:ecommerce/view/widget/auth/customtextformauth.dart';
import 'package:ecommerce/view/widget/auth/textsignup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPasswordControllerImp());
    return Scaffold(
        appBar: Customappbar(title: "Forget  password"),
        body: GetBuilder<ForgetPasswordControllerImp>(
            builder: (controller) => HandlingDataRequest(
                  statusRequest: controller.statusRequest,
                  widget: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                    child: Form(
                      key: controller.formstate,
                      child: ListView(children: [
                        CustomTextTitleAuth(
                          text1: "",
                          text2: "4".tr,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextFormAuth(
                          isNumber: false,
                          // ignore: body_might_complete_normally_nullable
                          valid: (val) {},
                          myController: controller.email,

                          hintText: '4'.tr,
                          labelText: "Email".tr,
                          suffixIcon: Icons.email_outlined,
                          //  myController: ,
                        ),
                        CustomButtonAuth(
                          text: "Check".tr,
                          onPressed: () {
                            controller.checkEmail();
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextSignUpOrIn(
                          onTap: () {
                            controller.goToSignup();
                          },
                          text: "6".tr,
                          texttwo: "Sign up".tr,
                        )
                      ]),
                    ),
                  ),
                )));
  }
}
