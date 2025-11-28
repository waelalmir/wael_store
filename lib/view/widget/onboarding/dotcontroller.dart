import 'package:ecommerce/controller/onboarding/onboardingcontroller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/data/datasource/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDotControllerOnBoarding extends StatelessWidget {
  const CustomDotControllerOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingControllerImp>(builder: (controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
              onBoardingList.length,
              (index) => AnimatedContainer(
                    margin: EdgeInsets.all(2),
                    duration: Duration(microseconds: 600),
                    width: controller.currentPage == index ? 20 : 5,
                    height: 4,
                    decoration: BoxDecoration(
                        color: AppColor.primeColor,
                        borderRadius: BorderRadius.circular(10)),
                  ))
        ],
      );
    });
  }
}
