import 'package:ecommerce/controller/auth/signupcontroller.dart';
import 'package:ecommerce/core/class/handlingdataview.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/class/functions/validinput.dart';
import 'package:ecommerce/core/shared/customappbar.dart';
import 'package:ecommerce/view/widget/auth/custombuttonauth.dart';
import 'package:ecommerce/view/widget/auth/customtextformauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpControllerImp());

    return Scaffold(
      appBar: Customappbar(title: 'Sign up'.tr),
      body: GetBuilder<SignUpControllerImp>(builder: (controller) {
        // ✅ نستخدم GetBuilder لإيجاد الكنترولر
        return HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
            child: Form(
              key: controller.formstate,
              child: ListView(children: [
                // ... (كل حقول الإدخال تبقى كما هي)
                // ...
                // حقل اسم المستخدم
                CustomTextFormAuth(
                  isNumber: false,
                  valid: (val) {
                    return validinput(val!, 3, 30, "username");
                  },
                  myController: controller.username,
                  hintText: '10'.tr,
                  labelText: "username",
                  suffixIcon: Icons.person_outline,
                ),
                // حقل البريد الإلكتروني
                CustomTextFormAuth(
                  isNumber: false,
                  valid: (val) {
                    return validinput(val!, 5, 100, "email");
                  },
                  myController: controller.email, // ✅ الربط صحيح
                  hintText: '4'.tr,
                  labelText: "Email".tr,
                  suffixIcon: Icons.email_outlined,
                ),
                // حقل الهاتف
                CustomTextFormAuth(
                  isNumber: true,
                  valid: (val) {
                    return validinput(val!, 5, 20, "phone");
                  },
                  myController: controller.phone, // ✅ الربط صحيح
                  hintText: ''.tr,
                  labelText: "phone",
                  suffixIcon: Icons.phone_outlined,
                ),
                // حقل كلمة المرور
                CustomTextFormAuth(
                  isNumber: false,
                  valid: (val) {
                    return validinput(val!, 5, 20, "password");
                  },
                  myController: controller.password, // ✅ الربط صحيح
                  hintText: '5'.tr,
                  labelText: "Password".tr,
                  suffixIcon: Icons.lock_outline_rounded,
                ),
                // زر الانتقال إلى تسجيل الدخول
                // ...
                InkWell(
                    onTap: () {
                      // ✅ استدعاء الدالة من نفس الكنترولر
                      controller.goToSignIn();
                    },
                    child: Text("Sign in".tr,
                        style: TextStyle(color: AppColor.primeColor))),
                CustomButtonAuth(
                  text: 'Sign up'.tr,
                  onPressed: () {
                    controller.signUp();
                  },
                ),
                // ...
              ]),
            ),
          ),
        );
      }),
    );
  }
}
