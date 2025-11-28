import 'package:ecommerce/controller/onboarding/onboardingcontroller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButonOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomButonOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      // width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.primeColor,
      ),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(horizontal: 100),
        onPressed: () {
          controller.next();
        },
        child: Text(
          "continue",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}
