import 'package:ecommerce/controller/forgetpassword/resetpasswordcontroller.dart';
import 'package:ecommerce/core/class/handlingdataview.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/shared/customappbar.dart';
import 'package:ecommerce/view/widget/auth/custombuttonauth.dart';
import 'package:ecommerce/view/widget/auth/customtextauth.dart';
import 'package:ecommerce/view/widget/auth/customtextformauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ResetPasswordControllerImp());
    return Scaffold(
        appBar: Customappbar(title: "Reset Password".tr),
        body: GetBuilder<ResetPasswordControllerImp>(
            builder: (controller) => HandlingDataRequest(
                  statusRequest: controller.statusRequest,
                  widget: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                    child: Form(
                      key: controller.formstate,
                      child: ListView(children: [
                        CustomTextTitleAuth(
                          text1: "",
                          text2: "5".tr,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextFormAuth(
                          isNumber: false,
                          // ignore: body_might_complete_normally_nullable
                          valid: (val) {},
                          myController: controller.password,

                          hintText: "5".tr,
                          labelText: "Password".tr,
                          suffixIcon: Icons.email_outlined,
                          //  myController: ,
                        ),
                        CustomTextFormAuth(
                          isNumber: false,
                          // ignore: body_might_complete_normally_nullable
                          valid: (val) {},
                          myController: controller.repassword,

                          hintText: "re enter your password",
                          labelText: "Password again".tr,
                          suffixIcon: Icons.email_outlined,
                          //  myController: ,
                        ),
                        CustomButtonAuth(
                          text: 'save',
                          onPressed: () {
                            controller.goToSuccessResetPassword();
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text("Dont have an account?"),
                        //     InkWell(
                        //         onTap: () {
                        //           controller.goToVerifayCode();
                        //         },
                        //         child: Text("Sign in",
                        //             style: TextStyle(color: AppColor.primaryColor)))
                        //   ],
                        // )
                      ]),
                    ),
                  ),
                )));
  }
}
