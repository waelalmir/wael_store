import 'package:ecommerce/controller/auth/logincontroller.dart';
import 'package:ecommerce/core/class/handlingdataview.dart';
import 'package:ecommerce/core/class/functions/validinput.dart';
import 'package:ecommerce/core/shared/customappbar.dart';
import 'package:ecommerce/core/shared/slidefade.dart';
import 'package:ecommerce/view/widget/auth/custombuttonauth.dart';
import 'package:ecommerce/view/widget/auth/customtextauth.dart';
import 'package:ecommerce/view/widget/auth/customtextformauth.dart';
import 'package:ecommerce/view/widget/auth/textsignup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return Scaffold(
      appBar: Customappbar(title: "Log in"),
      body: GetBuilder<LoginControllerImp>(builder: (controller) {
        return HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Form(
              key: controller.formstate,
              child: ListView(
                children: [
                  SlideFadeAnimationOffline(
                    delay: 100,
                    child: CustomTextTitleAuth(
                      text1: "",
                      text2: "3".tr,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SlideFadeAnimationOffline(
                    delay: 200,
                    child: CustomTextFormAuth(
                      isNumber: false,
                      valid: (val) => validinput(val!, 5, 100, "email"),
                      myController: controller.email,
                      hintText: '4'.tr,
                      labelText: "Email".tr,
                      suffixIcon: Icons.email_outlined,
                    ),
                  ),
                  SlideFadeAnimationOffline(
                    delay: 300,
                    child: CustomTextFormAuth(
                      ontapIcon: () => controller.onTapPassIcon(),
                      obscureText: controller.isshowpassword,
                      isNumber: false,
                      valid: (val) => validinput(val!, 5, 30, "password"),
                      myController: controller.password,
                      hintText: '5'.tr,
                      labelText: "Password".tr,
                      suffixIcon: controller.isshowpassword
                          ? Icons.lock_outline_rounded
                          : Icons.lock_open_rounded,
                    ),
                  ),
                  SlideFadeAnimationOffline(
                    delay: 400,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: controller.goToForgetPassword,
                        child: Text("Forget password".tr),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SlideFadeAnimationOffline(
                    delay: 500,
                    child: CustomButtonAuth(
                      text: 'Sign in'.tr,
                      onPressed: controller.login,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SlideFadeAnimationOffline(
                    delay: 600,
                    child: CustomTextSignUpOrIn(
                      onTap: controller.goToSignUp,
                      text: "6".tr,
                      texttwo: "7".tr,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
